module ActionMailer
  class Base
    class << self

      #
      # Returns an array of delivered mails.
      #
      def cached_deliveries
        File.open(cache_settings[:location], 'r') do |file|
          Marshal.load(file)
        end
      end

      #
      # Clears delivered mails.
      #
      def clear_cache
        deliveries.clear

        File.open(cache_settings[:location], 'w') do |file|
          Marshal.dump(deliveries, file)
        end
      end

    end # << self
  end # Base
end # ActionMailer
