class Order < ActiveRecord::Base
  belongs_to :address
  belongs_to :service
  has_many :order_logs
  validates_presence_of :service, :address

  state_machine :status, :initial => :drafted do
    event :make do
      transition :drafted => :created
    end

    event :confirm do
      transition :created => :confirmed
    end

    event :start do
      transition :confirmed => :started
    end

    event :complete do
      transition :started => :completed
    end

    event :close do
      transition [:completed] => :cancelled
    end

    event :cancel do
      transition [:drafted, :created, :confirmed] => :cancelled
    end

    state :started do
      validates_presence_of :actual_start_time
    end

    state :completed do
      validates_presence_of :actual_end_time
    end

    store_audit_trail to: OrderLog
  end

  after_create :make

  def self.find_orders(user_id)
    orders = Order.joins(:address).where('addresses.user_id' => user_id)
    orders.collect(&:fields_for_find_orders)
  end

  def fields_for_find_orders
    {order_id: id, slot_start_time: slot_start_time,
     status: status, service_name: service.name}
  end

  def fields_for_get_order
    as_json.symbolize_keys.tap do |fields|
      fields.except!(:updated_at, :address_id, :service_id)
      fields[:order_id] = fields.delete(:id)
      fields[:service_name] = service.name
      fields[:address] = address.as_json(except: [:updated_at, :created_at])
    end
  end
end
