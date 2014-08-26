# encoding: UTF-8

namespace :iqvoc_inflectionals do
  desc "Generate inflectionals based on a mapping table in the Inflectional model class."
  task :generate_inflectionals => :environment do
    Iqvoc::XLLabel.base_class.find_each do |label|
      label.generate_inflectionals!
    end
  end
end
