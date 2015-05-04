ServiceDiscovery::App.controllers :addresses do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  post :add_address, :map => '/users/:user_id/address' do
    address_params = get_create_address_params
    address_params[:user_id] = params[:user_id]
    address = Address.transaction do
      Address.create!(address_params)
    end
    status 201
    {address_id: address.id}.to_json
  end

end
