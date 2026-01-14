# encoding: utf-8
module Inflectionable
  extend ActiveSupport::Concern

  included do
    attr_reader :inflectionals_attributes
    after_save :overwrite_inflectionals!
    after_save :create_default_inflectional

    has_many :inflectionals,
             class_name: "Inflectional::Base",
             foreign_key: "label_id",
             dependent: :destroy,
             inverse_of: :label

    # overwrite class method to query labels by all existing inflectionals
    # instead of basic xl-label value attribute
    def self.by_query_value(query)
      Iqvoc::Xllabel.base_class
                    .references(:inflectionals)
                    .joins(:inflectionals)
                    .where('inflectionals.value ILIKE ?', query.to_s.downcase)
    end
  end

  def endings
    Inflectional::Base.for_language_and_code(language, inflectional_code)
  end

  def candidates
    Inflectional::Base.candidates_for(base_form, language, inflectional_code)
  end

  def generate_inflectionals!
    return send(Inflectional::Base.name.to_relation_name) if base_form.blank?

    candidates.each do |candidate|
      if candidate && inflectionals.where(value: candidate).none?
        send(Inflectional::Base.name.to_relation_name).create!(value: candidate)
      end
    end

    # self.base_form = new_base_form
    save(validate: false)

    inflectionals
  end

  def inflectionals_attributes=(str)
    @inflectionals_attributes = str.split("\r\n").uniq
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
    if value && inflectionals.empty?
      inflectionals.create(:value => value)
    end
  end
end
