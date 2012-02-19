module Mail
  class CacheDelivery

    def deliver!(mail)
      deliveries = File.open(ActionMailerCacheDelivery.deliveries_cache_path, 'r') do |f|
        Marshal.load(f)
      end

      deliveries << mail

      File.open(ActionMailerCacheDelivery.deliveries_cache_path, 'w') do |f|
        Marshal.dump(deliveries, f)
      end
    end

  end # CacheDelivery
end # Mail
