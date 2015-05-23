ServiceDiscovery::App.controllers :users do
  
  post '/:user_id/address' do
    get_create_address_params
    address = create_address @input, params[:user_id]
    status 201
    {address_id: address.id}.to_json
  end

  get '/:user_id/address' do
    addresses = Address.where('user_id' => params[:user_id])
    status 201
    {addresses: addresses}.to_json
  end

  put '/:user_id/update_address' do
    get_update_address_params
    user_id = get_valid_user_id params[:user_id]
    update_address user_id
    addresses = Address.where('user_id' => user_id)
    status 201
    {addresses: addresses}.to_json
  end

  post '/:user_id/delete_addresses' do
    get_delete_addresses_params
    Address.transaction do
      Address.destroy_all('user_id' => params[:user_id], 'id' => @input[:address_ids])
    end
    addresses = Address.where('user_id' => params[:user_id])
    status 201
    {addresses: addresses}.to_json
  end

  post '/' do
    get_create_user_params
    db_user = User.where('email_id' => @input[:email_id])
    if db_user.first.nil?
      update_user_params
      ActiveRecord::Base.transaction do
        @user = User.create!(@user_params)
        create_if_address_not_empty @user[:id]
      end
      status 201
      {user_id: @user[:id], new_user: true}.to_json
    else
      status 302
      {user_id: db_user.first[:id], new_user: false}.to_json
    end
  end
end
