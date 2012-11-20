# encoding: UTF-8

namespace :iqvoc_inflectionals do
  namespace :db do

    desc "Load seeds (task is idempotent)"
    task :seed => :environment do
      Iqvoc::Inflectionals::Engine.load_seed
    end

  end
end
