require_relative 'spec_helper'

describe ActionMailerCacheDelivery do

  context 'with Mailer' do
    let(:mail) do
      Mailer.test_mail
    end

    before(:each) do
      ActionMailerCacheDelivery.install
      ActionMailer::Base.delivery_method = :cache
      ActionMailer::Base.cache_settings[:location] = "#{Dir.tmpdir}/test.cache"
    end

    describe 'clear_cache' do
      it 'allows clearing cache before cache file is created' do
        ActionMailer::Base.cache_settings[:location] = ''
        expect { ActionMailer::Base.clear_cache }.not_to raise_error
      end

      it 'should clear cache file' do
        mail.deliver
        ActionMailer::Base.clear_cache
        mails = File.open(ActionMailer::Base.cache_settings[:location], 'r') do |file|
          Marshal.load(file)
        end
        expect(mails).to eq([])
      end

      it 'should clear ActionMailer::Base.deliveries' do
        mail.deliver
        ActionMailer::Base.clear_cache
        expect(ActionMailer::Base.deliveries).to eq([])
      end
    end

    describe 'cached_deliveries' do
      before(:each) do
        ActionMailer::Base.clear_cache
      end

      it 'returns empty array if cache has not been created yet' do
        expect(ActionMailer::Base.cached_deliveries).to eq([])
      end

      it 'should return array' do
        mail.deliver
        expect(ActionMailer::Base.cached_deliveries).to be_an(Array)
      end

      it 'should return all the sent emails' do
        5.times do
          mail.deliver
        end
        expect(ActionMailer::Base.cached_deliveries.length).to eq(5)
      end
    end
  end

  context 'without Mailer' do
    describe 'extend ActionMailer' do
      it 'should add cached_deliveries method to ActionMailer' do
        ActionMailerCacheDelivery.install
        expect(ActionMailer::Base).to respond_to(:cached_deliveries)
      end

      it 'should add clear_cache method to ActionMailer' do
        ActionMailerCacheDelivery.install
        expect(ActionMailer::Base).to respond_to(:clear_cache)
      end
    end

    describe 'install' do
      it 'should add :cache delivery method to ActionMailer' do
        ActionMailerCacheDelivery.install
        expect(ActionMailer::Base.delivery_methods).to include(:cache)
      end

      it 'should set cache path to /tmp when Rails is not defined' do
        hide_const('Rails')
        ActionMailerCacheDelivery.install
        ActionMailer::Base.delivery_method = :cache
        expect(ActionMailer::Base.cache_settings[:location])
          .to eq("#{Dir.tmpdir}/cache/action_mailer_cache_deliveries.cache")
      end
    end
  end
end # ActionMailerCacheDelivery
