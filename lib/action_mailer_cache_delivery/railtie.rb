module ActionMailerCacheDelivery
  class Railtie < Rails::Railtie

    #
    # Make settings available before configuration:
    #
    # @example
    #   config.action_mailer.delivery_method = :cache
    #   config.action_mailer.cache_settings = { location: "#{Rails.root}/tmp/mail.cache" }
    #
    config.before_configuration do
      ActionMailerCacheDelivery.install
    end

  end # Railtie
end # ActionMailerCacheDelivery
