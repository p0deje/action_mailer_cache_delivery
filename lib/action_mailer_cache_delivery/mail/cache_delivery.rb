module Mail
  #
  # Performs deliveries to temporary cache file, so mails can accessed from
  # other processes.
  #
  # Default location of files
  #
  class CacheDelivery

    attr_accessor :settings

    def initialize(settings)
      @settings = settings

      # create the cache directory if it doesn't exist
      cache_dir = File.dirname(@settings[:location])
      FileUtils.mkdir_p(cache_dir) unless File.directory?(cache_dir)

      # write empty array to cache file
      File.open(@settings[:location], 'w') do |file|
        Marshal.dump([], file)
      end
    end

    def deliver!(mail)
      mails = ActionMailer::Base.cached_deliveries
      mails << mail
      File.open(@settings[:location], 'w') do |file|
        Marshal.dump(mails, file)
      end
    end

  end # CacheDelivery
end # Mail
