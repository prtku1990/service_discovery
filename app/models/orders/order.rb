class Order < ActiveRecord::Base
  belongs_to :address
  belongs_to :service
  validates_presence_of :service, :address

  def self.find_orders(user_id)
    orders = Order.joins(:address).where('addresses.user_id' => user_id)
    orders.collect(&:fields_for_find_orders)
  end

  def fields_for_find_orders
    {order_id: id, start_time: slot_start_time,
     status: status, service_name: service.name}
  end
end
