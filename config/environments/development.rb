require 'debug'
require 'iqvoc/environments/development'

if Iqvoc::Inflectionals.const_defined?(:Application)
  Iqvoc::Inflectionals::Application.configure do
    # Settings specified here will take precedence over those in config/environment.rb
    Iqvoc::Environments.setup_development(config)
  end
end
