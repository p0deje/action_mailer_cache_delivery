module ActionMailer
  class Base
    class << self

      #
      # Returns an array of delivered mails.
      #
      # @return [Array] array of mails (each mail is an instance of Mail.)
      #
      def cached_deliveries
        with_cache_lock("#{cache_settings[:location]}.lock") do
          if File.exist?(cache_settings[:location])
            File.open(cache_settings[:location], 'r') do |file|
              Marshal.load(file)
            end
          else
            []
          end
        end
      end

      #
      # Clears delivered mails.
      #
      # It also cleans ActionMailer::Base.deliveries
      #
      def clear_cache
        with_cache_lock("#{cache_settings[:location]}.lock") do
          deliveries.clear

          if File.exist?(cache_settings[:location])
            File.open(cache_settings[:location], 'w') do |file|
              Marshal.dump(deliveries, file)
            end
          end
        end
      end

      #
      # Locks file to prevent concurrent mail jobs from race condition.
      # @api private
      #
      def with_cache_lock(file)
        lockfile = File.open(file, 'w')
        lockfile.flock(File::LOCK_EX)
        yield
      ensure
        lockfile.flock(File::LOCK_UN)
        lockfile.close
      end

    end # << self
  end # Base
end # ActionMailer
