require_relative 'spec_helper'

describe Mail::CacheDelivery do
  let(:mail) do
    Mailer.test_mail
  end

  before(:each) do
    ActionMailerCacheDelivery.install
    ActionMailer::Base.delivery_method = :cache
    ActionMailer::Base.clear_cache
  end

  describe 'settings' do
    it 'should allow setting custom location' do
      ActionMailer::Base.cache_settings = { location: '/tmp/mail.cache' }
      mail.deliver
      File.exists?('/tmp/mail.cache').should be_true
    end
  end

  describe 'deliver!' do
    it 'should write mail to cache file' do
      mail.deliver
      File.open(ActionMailer::Base.cache_settings[:location], 'r') do |file|
        Marshal.load(file)
      end.should == [mail]
    end

    it 'should append mail to cache file' do
      5.times do
        mail.deliver
      end
      File.open(ActionMailer::Base.cache_settings[:location], 'r') do |file|
        Marshal.load(file)
      end.length.should == 5
    end

    it 'should append mail to TestMailer deliveries' do
      mail.deliver
      Mail::TestMailer.deliveries.should == [mail]
    end
  end
end # Mail::CachedDelivery
