# encoding: UTF-8

require "label/skosxl/base"

class Label::SKOSXL::Base
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
