module Inflectionable
  extend ActiveSupport::Concern

  included do
    attr_reader :inflectionals_attributes
    after_save :overwrite_inflectionals!
    after_save :create_default_inflectional

    has_many :inflectionals,
      :class_name => "Inflectional::Base",
      :foreign_key => "label_id",
      :dependent => :destroy
  end

  def endings
    Inflectional::Base.for_language_and_code(language, inflectional_code)
  end

  def generate_inflectionals!
    return send(Inflectional::Base.name.to_relation_name) if base_form.blank?

    converted_literal_form = value.to_s

    diff = sanitize_base_form(converted_literal_form).size - base_form.size

    unless base_form.blank?
      # use special_char_count to build new base_from from literal-form (value)
      # necessary to deal with words containing special characters, e.g:
      # value = 'Außenwirtschaftsbeziehungen'
      # base_form = 'AUSSENWIRTSCHAFTSBEZIEHUNG'
      # wrong! => converted_literal_form[0..(base_form.length-1)] 'Außenwirtschaftsbeziehunge'
      # correct! => converted_literal_form[0..(base_form.length-1-special_char_count)] = 'Außenwirtschaftsbeziehungen'
      special_char_count = count_special_chars(converted_literal_form)
      new_base_form = converted_literal_form[0..(base_form.length-1-special_char_count)]
    end

    Rails.logger.debug "converted_literal_form => #{converted_literal_form} (#{converted_literal_form.size}) |
    base_form => #{base_form} (#{base_form.size}) |
    new_base_form => #{new_base_form} |
    value => #{value} (#{value.size}) |
    diff => #{diff}"

    endings.each do |ending|
      value = ending == "." ? new_base_form : (new_base_form + ending.downcase)
      if value != self.value
        # don't create inflectional only if differ from label value
        # otherwise we have two identical inflectionals
        send(Inflectional::Base.name.to_relation_name).create!(:value => value)
      end
    end

    self.base_form = new_base_form
    save(:validate => false)

    inflectionals
  end

  def sanitize_base_form(str)
    str.gsub(/[,\/\.\[\]]/, '')
  end

  def count_special_chars(str)
    str.count('ÖÄÜöäüß')
  end

  def inflectionals_attributes=(str)
    @inflectionals_attributes = str.split("\r\n")
  end

  def overwrite_inflectionals!
    return unless inflectionals_attributes
    transaction do
      inflectionals.delete_all
      inflectionals_attributes.each do |value|
        inflectionals.create!(:value => value)
      end
    end
  end

  def create_default_inflectional
    # ensure a matching inflectional exists
    if value && inflectionals.where(:value => value).none?
      inflectionals.create(:value => value)
    end
  end
end
