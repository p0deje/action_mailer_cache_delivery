module ActionMailer
  class Base
    class << self

      #
      # Returns an array of delivered mails.
      #
      # @return [Array] array of mails (each mail is an instance of Mail.)
      #
      def cached_deliveries
        if File.exists?(cache_settings[:location])
          File.open(cache_settings[:location], 'r') do |file|
            Marshal.load(file)
          end
        else
          []
        end
      end

      #
      # Clears delivered mails.
      #
      # It also cleans ActionMailer::Base.deliveries
      #
      def clear_cache
        deliveries.clear

        if File.exists?(cache_settings[:location])
          File.open(cache_settings[:location], 'w') do |file|
            Marshal.dump(deliveries, file)
          end
        end
      end

    end # << self
  end # Base
end # ActionMailer
