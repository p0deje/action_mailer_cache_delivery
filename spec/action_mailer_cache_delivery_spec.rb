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
        File.open(ActionMailer::Base.cache_settings[:location], 'r') do |file|
          Marshal.load(file)
        end.should == []
      end

      it 'should clear ActionMailer::Base.deliveries' do
        mail.deliver
        ActionMailer::Base.clear_cache
        ActionMailer::Base.deliveries.should == []
      end
    end

    describe 'cached_deliveries' do
      before(:each) do
        ActionMailer::Base.clear_cache
      end

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
        ActionMailer::Base.cache_settings[:location].should == "#{Dir.tmpdir}/cache/action_mailer_cache_deliveries.cache"
      end

      it 'should create full path to cache file' do
        path = 'test1/test2/'
        FileUtils.rm_rf(path) unless Dir.exists?(path) # remove directory if it exists
        ActionMailer::Base.delivery_method = :cache
        ActionMailer::Base.cache_settings = { :location => "#{path}/mail.cache" }
        ActionMailerCacheDelivery.install
        File.exists?("#{path}/mail.cache").should be_true
      end
    end
  end
end # ActionMailerCacheDelivery
