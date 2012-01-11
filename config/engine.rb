require 'rails'

module Iqvoc
  module Inflectionals

    class Engine < Rails::Engine

      paths.lib.tasks << "lib/engine_tasks"

    end

  end
end
