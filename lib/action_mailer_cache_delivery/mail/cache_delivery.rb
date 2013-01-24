module Mail
  #
  # Performs deliveries to temporary cache file, so mails can accessed from
  # other processes.
  #
  # Default location of files is:
  #   -  "tmp/cache/action_mailer_cache_deliveries.cache" if you use Rails
  #   - "/tmp/cache/action_mailer_cache_deliveries.cache" if you don't use Rails
  #
  # However, you can overwrite location in configuration:
  #
  # @example
  #   config.action_mailer.cache_settings = { location: "custom/path" }
  #
  class CacheDelivery

    # @attr [Hash] settings Settings for CacheDelivery
    attr_accessor :settings

    # @api private
    def initialize(settings)
      @settings = settings

      cache_dir = File.dirname(@settings[:location])
      FileUtils.mkdir_p(cache_dir) unless File.directory?(cache_dir)
    end

    # @api private
    def deliver!(mail)
      # write empty array to cache file if doesn't exist
      unless File.exists?(@settings[:location])
        File.open(@settings[:location], 'w') do |file|
          Marshal.dump([], file)
        end
      end

      # get delivered mails
      mails = ActionMailer::Base.cached_deliveries
      # append new one
      mails << mail
      # write all emails to cache file
      File.open(@settings[:location], 'w') do |file|
        Marshal.dump(mails, file)
      end

      Mail::TestMailer.deliveries << mail
    end

  end # CacheDelivery
end # Mail
