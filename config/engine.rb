require 'rails'

module Iqvoc
  module Inflectionals

    class Engine < Rails::Engine
      paths["lib/tasks"] << "lib/engine_tasks"
    end

    initializer "iqvoc_inflectionals.load_migrations" do |app|
      app.config.paths['db/migrate'] += Iqvoc::Inflectionals::Engine.paths['db/migrate'].existent
    end

  end
end
