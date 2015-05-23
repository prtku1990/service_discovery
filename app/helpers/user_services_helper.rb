# def get_create_user_params
#   @input = parse_request
#   print @input
#   validates_presence_of :email_id, :password, :gender, :address
# end

def get_create_address_params
  @input = parse_request
  validates_presence_of :name, :line1, :line2, :city, :state, :pincode , :phone_number
end

def create_address(address_params, user_id)
  address_params[:user_id] = get_valid_user_id user_id
  address_params[:is_primary] = is_primary_address address_params
  address = Address.transaction do
    Address.create!(address_params)
  end
  return address
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

def update_user_params
  @user_params = {} #defining empty hash
  @user_params[:email_id] = @input[:email_id]
  if @input[:password].nil?
    @user_params[:password] = 'opendoors'
  end

  if !@input[:gender].nil?
    @user_params[:gender] = @input[:gender]
  end

  if !@input[:login_type].nil?
    @user_params[:login_type] = @input[:login_type]
  else
    @user_params[:login_type] = "Google"
  end
end

def is_primary_address(address_params)
  if !address_params.has_key?("is_primary") then
      return false
  end
  return true
end

def update_address (user_id)
  existing_address = Address.where('user_id' => user_id, 'id' => @input[:address_id]).as_json;
  if !existing_address.empty? then
    validates_presence_of :name, :line1, :line2, :city, :state, :pincode , :phone_number, @input[:address]
    Address.transaction do
      old_address = Address.find(@input[:address_id])
      old_address.update_attributes(@input[:addresses])
    end
  else
    raise StandardError.new("There is no address associated with address_id: #{@input[:address_id]} and user_id : #{user_id}")
  end
end

def get_valid_user_id (user_id)
  User.find(user_id);
  return user_id
end

def create_if_address_not_empty (user_id)
  if !@input[:address].nil?
    validates_presence_of :name, :line1, :line2, :city, :state, :pincode , :phone_number, @input[:address]
    create_address @input[:address], user_id
  end
end