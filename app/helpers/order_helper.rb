def get_create_order_params
  @input = parse_request
  validates_presence_of :start_time, :service_id, :address_id
  @input[:slot_start_time] = @input.delete(:start_time)
  @input.slice(:slot_start_time, :service_id, :address_id)
end