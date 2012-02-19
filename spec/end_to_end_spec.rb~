require_relative 'spec_helper'

describe ActionMailerCacheDelivery do

#  let(:mail) {  }
  subject { ActionMailer::Base }

  before(:each) do
    subject.delivery_method = :cache
    subject.clear_cache
    @mail = Mailer.testmail
  end

  it { should respond_to(:cached_deliveries) }
  it { should respond_to(:clear_cache) }

  it "should deliver mail to our cache when delivery_method is set to :cache" do
    Mailer.any_instance.expects(:perform_delivery_cache).with(Mailer.testmail)
    Mailer.testmail.deliver
  end

  it "should not deliver mail to our cache when delivery_method is not set to :cache" do
    subject.delivery_method = :test
    Mailer.should_not_receive(:perform_delivery_cache)
    @mail.deliver
  end

  it "should append mail to the cache" do
    subject.cached_deliveries.should be_empty
    5.times do |i|
      @mail.deliver
      subject.cached_deliveries.size.should == (i + 1)
    end
  end

  it "should be clearable" do
    @mail.deliver
    subject.cached_deliveries.should_not be_empty
    subject.clear_cache
    subject.cached_deliveries.should be_empty
  end

end # ActionMailerCacheDelivery
