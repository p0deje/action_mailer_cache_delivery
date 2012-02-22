require_relative 'spec_helper'

describe Mail::CacheDelivery do
  let(:mail) do
    Mailer.test_mail
  end

  before(:each) do
    ActionMailerCacheDelivery.install
    ActionMailer::Base.delivery_method = :cache
  end

  describe 'settings' do
    it 'should allow setting custom location' do
      ActionMailer::Base.cache_settings = { location: '/tmp/mail.cache' }
      mail.deliver
      File.exists?('/tmp/mail.cache').should be_true
    end
  end

  describe 'deliver' do
    it 'should write mail to cache file' do
      mail.deliver
      file = ActionMailer::Base.cache_settings[:location]
      File.open(file, 'r') { |f| Marshal.load(f) }.should == [mail]
    end

    it 'should append mail to cache file' do
      mail.deliver
      file = ActionMailer::Base.cache_settings[:location]
      File.open(file, 'r') { |f| Marshal.load(f) }.length.should == 2
    end
  end
end # Mail::CachedDelivery
