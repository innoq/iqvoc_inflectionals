require 'rails'

module Iqvoc
  module Inflectionals

    class Engine < Rails::Engine

      paths.lib.tasks  << "lib/engine_tasks"

      def self.load_seed
        seed_file = Iqvoc::Inflectionals::Engine.find_root_with_flag("db").join("db/seeds.rb")
        load(seed_file) if File.exist?(seed_file)
      end

    end

  end
end
