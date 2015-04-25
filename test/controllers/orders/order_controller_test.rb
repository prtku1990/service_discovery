require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class OrderControllerTest < ActiveSupport::TestCase
  context 'Create' do
    should 'Return error if start_time is not present in request' do
      payload = {service_id: 1, address_id: 1}
      assert_raises StandardError.new('Parameter start_time is mandatory') do
        post '/orders', payload.to_json
      end
    end

    should 'Return error if service_id is not present in request' do
      payload = {start_time: "2015-05-05 17:00:00", address_id: 1}
      assert_raises StandardError.new('Parameter service_id is mandatory') do
        post '/orders', payload.to_json
      end
    end

    should 'Return error if address_id is not present in request' do
      payload = {start_time: "2015-05-05 17:00:00", service_id: 1}
      assert_raises StandardError.new('Parameter address_id is mandatory') do
        post '/orders', payload.to_json
      end
    end

    should 'Return error if service is invalid' do
      FactoryGirl.create(:address, id: 1)
      payload = {start_time: '2015-05-05 17:00:00', service_id: 1, address_id: 1}
      assert_raises ActiveRecord::RecordInvalid do
        post '/orders', payload.to_json
      end
    end

    should 'Return error if address is invalid' do
      FactoryGirl.create(:service, id: 1)
      payload = {start_time: '2015-05-05 17:00:00', service_id: 1, address_id: 1}
      assert_raises ActiveRecord::RecordInvalid do
        post '/orders', payload.to_json
      end
    end

    should 'Create order and return Id' do
      FactoryGirl.create(:service, id: 1)
      FactoryGirl.create(:address, id: 1)
      payload = {start_time: '2015-05-05 17:00:00', service_id: 1, address_id: 1}
      post '/orders', payload.to_json
      assert_equal 1, Order.count
      order = Order.first
      assert_order_fields(payload, order)
      assert_equal({order_id: order.id}.to_json, last_response.body)
    end
  end

  def assert_order_fields(input, order)
    assert_equal input[:address_id], order.address_id
    assert_equal input[:service_id], order.service_id
    assert_equal input[:start_time], order.slot_start_time.to_s(:db)
  end

  context 'get orders' do
    should 'call find_orders and return json response' do
      expected_orders = [{order_id: 1, start_time: Time.now, status: 'created', service_name: 'service1'},
                         {order_id: 2, start_time: Time.now, status: 'completed', service_name: 'service2'}]
      Order.expects(:find_orders).with('1').returns(expected_orders)
      get '/orders?user_id=1'
      assert_equal expected_orders.to_json, last_response.body
    end
  end

  context 'get order by id' do
    should 'call fields_for_get_order and return json' do
      order = FactoryGirl.create(:order)
      expected_payload = {order_id: 123, other_fields: 'other_fields'}
      Order.any_instance.expects(:fields_for_get_order).returns(expected_payload)
      get "/orders/#{order.id}"
      assert_equal expected_payload.to_json, last_response.body
    end
  end
end