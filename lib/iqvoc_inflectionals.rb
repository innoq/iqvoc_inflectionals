# encoding: UTF-8

require 'iqvoc/inflectionals/version'

module IqvocInflectionals

  unless Iqvoc.const_defined?(:Inflectionals) && Iqvoc::Inflectionals.const_defined?(:Application)
    require File.join(File.dirname(__FILE__), '../config/engine')
  end

  ActiveSupport.on_load(:after_iqvoc_config) do
    require 'iqvoc'
  end

end
