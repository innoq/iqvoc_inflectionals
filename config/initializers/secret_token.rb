# encoding: UTF-8

# Be sure to restart your server when you modify this file.

if Iqvoc::Inflectionals.const_defined?(:Application)

  # Your secret key for verifying the integrity of signed cookies.
  # If you change this key, all old signed cookies will become invalid!
  # Make sure the secret is at least 30 characters and all random,
  # no regular words or you'll be exposed to dictionary attacks.

  # Run `rake secret` and uncomment the following line
  # Replace the secret-placeholder with your generated token
  Iqvoc::Inflectionals::Application.config.secret_token = "8416495f22b2945c6961b2995e0b0ebe4fc01ae2da7e7f9b9b6611d5bf8735bd7edfea29fb37e107fb483946d1dfa8de6c2f468f93e1dfd24b460ff94ee192fe"

end
