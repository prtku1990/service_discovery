ENV['RACK_ENV'] = 'test'

require File.expand_path(File.dirname(__FILE__) + '/../../../test_config.rb')

class UserControllerTest < ActiveSupport::TestCase

  context 'AddAddress' do
    should 'Return error if name is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'}
      assert_raise StandardError.new('Parameter name is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end

    should 'Return error if line1 is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {name: 'santhosh', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'}
      assert_raise StandardError.new('Parameter line1 is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end

    should 'Return error if line2 is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {name: 'santhosh', line1: 'first line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'}
      assert_raise StandardError.new('Parameter line2 is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end

    should 'Return error if city is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {name: 'santhosh', line1: 'first line', line2: 'second line', state: 'KA', pincode: '532421', phone_number: '9538255159'}
      assert_raise StandardError.new('Parameter city is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end

    should 'Return error if state is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore',  pincode: '532421', phone_number: '9538255159'}
      assert_raise StandardError.new('Parameter state is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end

    should 'Return error if pincode is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA',  phone_number: '9538255159'}
      assert_raise StandardError.new('Parameter pincode is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end


    should 'Return error if phone_number is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421'}
      assert_raise StandardError.new('Parameter phone_number is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end

    should 'Create address' do
      user = FactoryGirl.create(:user)
      payload = {name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'}
      post "/users/#{user.id}/address", payload.to_json
      assert_equal 1, Address.count
      address = Address.first
      assert_equal address[:user_id], user.id
      assert_address_fields address, payload
    end

    def assert_address_fields(address, payload)
      assert_equal address[:name], payload[:name]
      assert_equal address[:line1], payload[:line1]
      assert_equal address[:line2], payload[:line2]
      assert_equal address[:city], payload[:city]
      assert_equal address[:state], payload[:state]
      assert_equal address[:pincode], payload[:pincode]
      assert_equal address[:phone_number], payload[:phone_number]
    end
  end

  context 'get Address' do
    should 'call get addresses and return json response' do
      expected_addresses = [{name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'},
                            {name: 'tvs', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255160'}]
      Address.expects(:where).returns(expected_addresses)
      get '/users/1/address'
      result = {addresses: expected_addresses}.to_json
      assert_equal result, last_response.body
    end
  end

  context 'update address' do
    should 'Return error if address_id does not present' do
      user = FactoryGirl.create(:user)
      payload = {address: { line1: "186, some building", line2: "someother road", land_mark: "near that",
          city: "moholla", state: "rajya", pincode: "1299468", name: "naam", phone_number: "9898989898"}}
      assert_raise StandardError.new('Parameter address_id is mandatory') do
        put "/users/#{user.id}/update_address", payload.to_json
      end
    end

    should 'Return error if address does not present' do
      user = FactoryGirl.create(:user)
      payload = { address_id: 1}
      assert_raise StandardError.new('Parameter address is mandatory') do
        put "/users/#{user.id}/update_address", payload.to_json
      end
    end

    # should 'Return error if address does not present against user_id' do
    #   user = FactoryGirl.create(:user)
    #   expected_addresses = [{name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'},
    #                         {name: 'tvs', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255160'}]
    #   existing_address = {name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'}
    #   payload = { address_id: 1, address: { line1: "186, some building", line2: "someother road", land_mark: "near that",
    #                                         city: "moholla", state: "rajya", pincode: "1299468", name: "naam", phone_number: "9898989898"}}
    #   Address.expects(:where).returns(existing_address)
    #   Address.expects(:find).returns(existing_address)
    #
    #   put "/users/#{user.id}/update_address", payload.to_json
    # end

  end
end
