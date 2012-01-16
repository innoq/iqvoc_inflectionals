# encoding: UTF-8
require "iqvoc/inflectionals/label_extensions"

Rails.application.config.to_prepare do
  Label::SKOSXL::Base.send(:include, Iqvoc::Inflectionals::LabelExtensions)
end
