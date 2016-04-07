# encoding: utf-8
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

    endings.each do |ending|
      value = ending == '.' ? base_form : (base_form + ending.downcase)
      # create inflectional only if differ from label value
      next if value == self.value

      if value && inflectionals.where(:value => value).none?
        send(Inflectional::Base.name.to_relation_name).create!(value: value)
      end
    end

    # self.base_form = new_base_form
    save(validate: false)

    inflectionals
  end

  def inflectionals_attributes=(str)
    @inflectionals_attributes = str.split("\r\n")
  end

  def overwrite_inflectionals!
    return unless inflectionals_attributes
    transaction do
      inflectionals.delete_all
      inflectionals_attributes.each do |value|
        inflectionals.create!(value: value)
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
