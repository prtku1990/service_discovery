require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class VeteranTest < Test::Unit::TestCase
  context "Veteran Model" do
    should 'construct new instance' do
      @veteran = Veteran.new
      assert_not_nil @veteran
    end
  end
end
