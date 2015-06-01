class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  def self.create_address(address_params, user_id)
    valid_user_id user_id
    address_params[:user_id] = user_id
    address_params[:is_primary] = is_primary_address address_params
    address = Address.transaction do
      Address.create!(address_params)
    end
    return address
  end

  def self.update_address (address_params, address_id, user_id)
    existing_address = Address.find_by_id_and_user_id!(address_id, user_id)
    if existing_address.present?
      validates_presence_of :name, :line1, :line2, :city, :state, :pincode , :phone_number, {:in => address_params}
      Address.transaction do
        old_address = Address.find(address_id)
        old_address.update_attributes(address_params)
      end
    else
      raise StandardError.new("There is no address associated with address_id: #{address_id} and user_id : #{user_id}")
    end
  end
end
