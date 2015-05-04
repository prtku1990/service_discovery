# Helper methods defined here can be accessed in any controller or view in the application
def get_create_address_params
  @input = parse_request
  validates_presence_of :name, :line1, :line2, :city, :state, :pincode , :phone_number
  return @input
end