class Pricer
  attr_accessor :order
  BUFFER_SECONDS = 300

  def initialize(order)
    @order = order
  end

  def calculate_price
    base_price = @order.service.price_per_hour
    service_time_in_sec = @order.actual_end_time - @order.actual_start_time - BUFFER_SECONDS
    price = (base_price * service_time_in_sec/3600).to_i
    @order.update_attributes!(total_price: price)
  end
end