ServiceDiscovery::App.controllers :orders do

  #TODO: Return custom generated Order Id
  post '/' do
    params = get_create_order_params
    order = Order.transaction do
      Order.create!(params)
    end
    status 201
    {order_id: order.id}.to_json
  end

  get '/' do
    Order.find_orders(params[:user_id]).to_json
  end

  get '/:id' do
    order = Order.find(params[:id])
    order.fields_for_get_order.to_json
  end

  put '/:id/confirm' do
    Order.find(params[:id]).confirm!
  end

  put '/:id/start' do
    @input = parse_request
    order = Order.find(params[:id])
    Order.transaction do
      order.update_attributes!(actual_start_time: @input[:start_time])
      order.start!
    end
  end

  put '/:id/complete' do
    @input = parse_request
    order = Order.find(params[:id])
    Order.transaction do
      order.update_attributes!(actual_end_time: @input[:end_time])
      order.complete!
    end
  end

  put '/:id/cancel' do
    order = Order.find(params[:id])
    Order.transaction do
      order.cancel!
    end
  end
end