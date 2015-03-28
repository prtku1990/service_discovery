require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class AddressTest < Test::Unit::TestCase
  context "Address Model" do
    should 'construct new instance' do
      @address = Address.new
      assert_not_nil @address
    end
  end
end
