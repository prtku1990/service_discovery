require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class CustomerTest < ActiveSupport::TestCase
  context "Customer Model" do
    should 'construct new instance' do
      @customer = Customer.new
      assert_not_nil @customer
    end
  end
end
