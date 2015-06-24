# def get_create_user_params
#   @input = parse_request
#   print @input
#   validates_presence_of :email_id, :password, :gender, :address
# end

def get_create_address_params
  @input = parse_request
  @input = @input[:address]
  validates_presence_of :name, :line1, :pincode , :phone_number
end

def get_update_address_params
  @input = parse_request
  validates_presence_of :address_id, :address
end

def get_delete_addresses_params
  @input = parse_request
  validates_presence_of :address_ids
end

def get_create_user_params
  @input = parse_request
  validates_presence_of :email_id
end

def is_primary_address(address_params)
  if !address_params.has_key?("is_primary")
      return false
  end
  return address_params[:is_primary]
end

def valid_user_id (user_id)
  User.find(user_id);
end
