require File.expand_path(File.dirname(__FILE__) + '/../../../test_config.rb')

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
      assert_order_log_created(payload, order)
      assert_equal({order_id: order.id}.to_json, last_response.body)
    end
  end

  def assert_order_fields(input, order)
    assert_equal input[:address_id], order.address_id
    assert_equal input[:service_id], order.service_id
    assert_equal input[:start_time], order.slot_start_time.to_s(:db)
  end

  def assert_order_log_created(input, order)
    assert_equal 2, order.order_logs.count
    assert_equal ['drafted', 'created'], order.order_logs.collect(&:to)
  end

  context 'get orders' do
    should 'call find_orders and return json response' do
      expected_orders = [{order_id: 1, start_time: Time.now, status: 'created', service_name: 'service1'},
                         {order_id: 2, start_time: Time.now, status: 'completed', service_name: 'service2'}]
      Order.expects(:find_orders).with('1').returns(expected_orders)
      get '/orders?user_id=1'
      assert_equal({orders: expected_orders}.to_json, last_response.body)
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

  context 'confirm order' do
    should 'confirm order if confirmation is possible' do
      order = FactoryGirl.create(:order)
      put "/orders/#{order.id}/confirm"
      assert_true order.reload.confirmed?
    end

    should 'raise exception if confirmation is not possible' do
      order = FactoryGirl.create(:order, status: 'started', actual_start_time: Time.now)
      assert_raises StateMachine::InvalidTransition do
        put "/orders/#{order.id}/confirm"
      end
    end

    should 'raise exception if order id is invalid' do
      assert_raises ActiveRecord::RecordNotFound do
        put "/orders/2/confirm"
      end
    end
  end

  context 'start order' do
    should 'update actual start time and start order' do
      order = FactoryGirl.create(:order, status: 'confirmed')
      put "/orders/#{order.id}/start", {start_time: "2015-04-04 10:15:00"}.to_json
      assert_true order.reload.started?
      assert_equal "2015-04-04 10:15:00", order.actual_start_time.to_s(:db)
    end

    should 'raise exception if start is not possible' do
      order = FactoryGirl.create(:order)
      assert_raises StateMachine::InvalidTransition do
        put "/orders/#{order.id}/start", {start_time: "2015-04-04 10:15:00"}.to_json
      end
    end

    should 'raise exception if order id is invalid' do
      assert_raises ActiveRecord::RecordNotFound do
        put "/orders/2/start", {start_time: "2015-04-04 10:15:00"}.to_json
      end
    end
  end

  context 'complete order' do
    should 'update actual end time and complete order' do
      order = FactoryGirl.create(:order, status: 'started', actual_start_time: Time.now)
      put "/orders/#{order.id}/complete", {end_time: "2015-04-04 10:15:00"}.to_json
      assert_true order.reload.completed?
      assert_equal "2015-04-04 10:15:00", order.actual_end_time.to_s(:db)
    end

    should 'raise exception if complete is not possible' do
      order = FactoryGirl.create(:order)
      assert_raises StateMachine::InvalidTransition do
        put "/orders/#{order.id}/complete", {end_time: "2015-04-04 10:15:00"}.to_json
      end
    end

    should 'raise exception if order id is invalid' do
      assert_raises ActiveRecord::RecordNotFound do
        put "/orders/2/complete", {end_time: "2015-04-04 10:15:00"}.to_json
      end
    end
  end

  context 'cancel order' do
    should 'cancel order' do
      order = FactoryGirl.create(:order)
      put "/orders/#{order.id}/cancel"
      assert_true order.reload.cancelled?
    end

    should 'raise exception if cancel is not possible' do
      order = FactoryGirl.create(:order, status: 'completed', actual_end_time: Time.now)
      assert_raises StateMachine::InvalidTransition do
        put "/orders/#{order.id}/cancel"
      end
    end

    should 'raise exception if order id is invalid' do
      assert_raises ActiveRecord::RecordNotFound do
        put "/orders/2/cancel"
      end
    end
  end
 end