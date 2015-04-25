ServiceDiscovery::App.controllers :orders do

  #TODO: Return custom generated Order Id
  post '/' do
    params = get_create_order_params
    order = Order.create!(params)
    status 201
    {order_id: order.id}.to_json
  end

  get '/' do
    Order.find_orders(params[:user_id]).to_json
  end
end