require_relative 'spec_helper'

describe ActionMailerCacheDelivery do

  context 'with Mailer' do
    let(:mail) do
      Mailer.test_mail
    end

    before(:each) do
      ActionMailerCacheDelivery.install
      ActionMailer::Base.delivery_method = :cache
    end

    describe 'clear_cache' do
      it 'should clear cache file' do
        mail.deliver
        ActionMailer::Base.clear_cache
        file = ActionMailer::Base.cache_settings[:location]
        File.open(file, 'r') { |f| Marshal.load(f) }.should == []
      end

      it 'should clear ActionMailer::Base.deliveries' do
        mail.deliver
        ActionMailer::Base.clear_cache
        ActionMailer::Base.deliveries.should == []
      end
    end

    describe 'cached_deliveries' do
      it 'should return array' do
        mail.deliver
        ActionMailer::Base.cached_deliveries.should be_an(Array)
      end

      it 'should return all the sent emails' do
        5.times do
          mail.deliver
        end
        ActionMailer::Base.cached_deliveries.length.should == 5
      end
    end
  end

  context 'without Mailer' do
    describe 'extend ActionMailer' do
      it 'should add cached_deliveries method to ActionMailer' do
        ActionMailerCacheDelivery.install
        ActionMailer::Base.should respond_to(:cached_deliveries)
      end

      it 'should add clear_cache method to ActionMailer' do
        ActionMailerCacheDelivery.install
        ActionMailer::Base.should respond_to(:clear_cache)
      end
    end

    describe 'install' do
      it 'should add :cache delivery method to ActionMailer' do
        ActionMailerCacheDelivery.install
        ActionMailer::Base.delivery_methods.should include(:cache)
      end

      it 'should set cache path to /tmp when Rails is not defined' do
        ActionMailerCacheDelivery.install
        ActionMailer::Base.delivery_method = :cache
        ActionMailer::Base.cache_settings[:location].should == '/tmp/cache/action_mailer_cache_deliveries.cache'
      end
    end
  end
end # ActionMailerCacheDelivery
