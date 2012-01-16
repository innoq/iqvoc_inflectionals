# encoding: UTF-8

require "active_support/concern"

module Inflectional::LabelExtension
  extend ActiveSupport::Concern

  included do
    attr_reader :inflectionals_attributes
    after_save :overwrite_inflectionals!
  end

  def endings
    Inflectional::Base.for_language_and_code(language, inflectional_code)
  end

  def generate_inflectionals!
    return send(Inflectional::Base.name.to_relation_name) if base_form.blank?

    converted_literal_form = OriginMapping.replace_umlauts(value)

    diff = OriginMapping.sanitize_for_base_form(converted_literal_form).size - base_form.size

    unless base_form.blank?
      new_base_form = converted_literal_form[0..(base_form.length-1)]
    end

    Rails.logger.debug "converted_literal_form => #{converted_literal_form} (#{converted_literal_form.size}) |
    base_form => #{base_form} (#{base_form.size}) |
    new_base_form => #{new_base_form} |
    value => #{value} (#{value.size}) |
    diff => #{diff}"

    endings.each do |ending|
      value = ending == "." ? new_base_form : (new_base_form + ending.downcase)
      send(Inflectional::Base.name.to_relation_name).create!(:value => value)
    end

    self.base_form = new_base_form
    save(:validate => false)

    send(Inflectional::Base.name.to_relation_name)
  end

  def inflectionals_attributes=(str)
    @inflectionals_attributes = str.split("\r\n")
  end

  def overwrite_inflectionals!
    return unless inflectionals_attributes
    transaction do
      send(Inflectional::Base.name.to_relation_name).delete_all
      inflectionals_attributes.each do |value|
        send(Inflectional::Base.name.to_relation_name).create!(:value => value)
      end
    end
  end
end
