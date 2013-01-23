require 'action_mailer_cache_delivery/version'
require 'action_mailer_cache_delivery/mail/cache_delivery'
require 'action_mailer_cache_delivery/action_mailer/base'
require 'action_mailer_cache_delivery/railtie' if defined?(Rails)

module ActionMailerCacheDelivery
  class << self

    def install
      default_path = 'cache/action_mailer_cache_deliveries.cache'
      location = defined?(Rails) ? "#{Rails.root}/tmp/#{default_path}" : "#{Dir.tmpdir}/#{default_path}"
      ActionMailer::Base.add_delivery_method :cache, Mail::CacheDelivery, location: location

      create_cache_dir location
    end

    def create_cache_dir(location)
      # create the cache directory if it doesn't exist
      cache_dir = File.dirname(location)
      FileUtils.mkdir_p(cache_dir) unless File.directory?(cache_dir)
    end

  end # << self
end # ActionMailerCacheDelivery
