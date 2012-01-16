# encoding: UTF-8

require "active_support/concern"

module Iqvoc::Inflectionals::LabelExtensions
  extend ActiveSupport::Concern

  included do
    include Inflectional::LabelExtension

    after_save do |label|
      # ensure a matching inflectional exists
      if Inflectional::Base.where(:label_id => label.id, :value => label.value).none?
        label.inflectionals.create(:value => label.value)
      end
    end

    has_many :inflectionals,
        :class_name  => "Inflectional::Base",
        :foreign_key => "label_id",
        :dependent   => :destroy
  end
end
