require 'action_mailer_cache_delivery/version'
require 'action_mailer_cache_delivery/mail/cache_delivery'
require 'action_mailer_cache_delivery/action_mailer/base'

module ActionMailerCacheDelivery
  class << self

    def install
      default_path = 'cache/action_mailer_cache_deliveries.cache'
      location = defined?(Rails) ? "#{Rails.root}/tmp/#{default_path}" : "#{Dir.tmpdir}/#{default_path}"
      ActionMailer::Base.add_delivery_method :cache, Mail::CacheDelivery, location: location
    end

  end # << self
end # ActionMailerCacheDelivery

require 'action_mailer_cache_delivery/railtie' if defined?(Rails)
