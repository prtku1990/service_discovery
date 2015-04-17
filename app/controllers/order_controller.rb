ServiceDiscovery::App.controllers :orders do
  post '/' do
    params = get_create_order_params
    Order.create!(params)
    201
  end
end