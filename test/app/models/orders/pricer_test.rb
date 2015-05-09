require File.expand_path(File.dirname(__FILE__) + '/../../../test_config.rb')

class PriceTest < ActiveSupport::TestCase
  context "Calculate Price" do
    should "set expected price for an order" do
      service = FactoryGirl.create(:service, price_per_hour: 150)
      order = FactoryGirl.create(:order, actual_start_time: "2015-04-04 12:06:00", actual_end_time: "2015-04-04 13:11:00", service: service)
      Pricer.new(order).calculate_price
      assert_equal 150, order.total_price
    end
  end
end