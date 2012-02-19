require 'fileutils'
require 'action_mailer_cache_delivery/version'
require 'action_mailer_cache_delivery/action_mailer/base'
require 'action_mailer_cache_delivery/railtie' if defined?(Rails)
require 'action_mailer_cache_delivery/mail/cache_delivery'

module ActionMailerCacheDelivery
  class << self
    #
    # Path to save deliveries.
    #
    attr_accessor :deliveries_cache_path

    #
    # Installs ActionMailerCacheDelivery.
    #
    def install
      # initialize path to save deliveries
      root = Rails.root if defined?(Rails)
      @deliveries_cache_path ||= "#{root}/tmp/cache/action_mailer_cache_deliveries#{ENV['TEST_ENV_NUMBER']}"

      # add delivery method to ActionMailer
      ActionMailer::Base.add_delivery_method(:cache, Mail::CacheDelivery)

      # create the cache directory if it doesn't exist
      cache_dir = File.dirname(deliveries_cache_path)
      FileUtils.mkdir_p(cache_dir) unless File.directory?(cache_dir)

      # marshal empty list of deliveries
      File.open(deliveries_cache_path, 'w') { |f| Marshal.dump(Array.new, f) }
    end
  end # << self
end # ActionMailerCacheDelivery
