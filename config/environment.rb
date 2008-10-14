# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.1.1' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_fearticker_session',
    :secret      => '78e85b384a208f594c3f6b2a2a61a93c71929a6ab419630faa14fd1eafa0ee88f4758d7c629fc2004a203d7da24bb7486174b2ef91b3f1fba1677fae53866bf9'
  }

  config.cache_store = :memory_store
  config.gem "RedCloth"
end

require 'open-uri'


