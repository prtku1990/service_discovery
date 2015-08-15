ENV['RACK_ENV'] = 'test'

require File.expand_path(File.dirname(__FILE__) + '/../../../test_config.rb')

class UserControllerTest < ActiveSupport::TestCase

  context 'AddAddress' do
    should 'Return error if name is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {address: {line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'}}
      assert_raise StandardError.new('Parameter name is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end

    should 'Return error if line1 is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {address: {name: 'santhosh', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'}}
      assert_raise StandardError.new('Parameter line1 is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end

    should 'Return error if pincode is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {address: {name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA',  phone_number: '9538255159'}}
      assert_raise StandardError.new('Parameter pincode is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end


    should 'Return error if phone_number is not present in request' do
      user = FactoryGirl.create(:user)
      payload = {address: {name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421'}}
      assert_raise StandardError.new('Parameter phone_number is mandatory') do
        post "/users/#{user.id}/address", payload.to_json
      end
    end

    should 'Create address' do
      user = FactoryGirl.create(:user)
      payload = {address:
                     {name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore',
                      state: 'KA', pincode: '532421', phone_number: '9538255159'}
      }
      post "/users/#{user.id}/address", payload.to_json
      assert_equal 1, Address.count
      address = Address.first
      assert_equal address[:user_id], user.id
      assert_address_fields address, payload[:address]
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
      payload = {address: { line1: "186, some building", line2: "someother road", landmark: "near that",
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
    #   payload = { address_id: 1, address: { line1: "186, some building", line2: "someother road", landmark: "near that",
    #                                         city: "moholla", state: "rajya", pincode: "1299468", name: "naam", phone_number: "9898989898"}}
    #   Address.expects(:where).returns(existing_address)
    #   Address.expects(:find).returns(existing_address)
    #
    #   put "/users/#{user.id}/update_address", payload.to_json
    # end
  end

  context 'Delete Addresses' do
    should 'Return error if address_ids does not present' do
      payload = {}
      assert_raise StandardError.new('Parameter address_ids is mandatory') do
        post "/users/1/delete_addresses", payload.to_json
      end
    end

    should 'delete addresses' do
      payload = {address_ids: [1,2,3,5]}
      expected_addresses = [{name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'},
                            {name: 'tvs', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255160'}]
      Address.expects(:where).returns(expected_addresses)
      post "/users/1/delete_addresses", payload.to_json
      result = {addresses: expected_addresses}.to_json
      assert_equal result, last_response.body
    end
  end

  context 'Create User' do
    should 'Return error if email_id does not present' do
      payload = {}
      assert_raise StandardError.new('Parameter email_id is mandatory') do
        post "/users/", payload.to_json
      end
    end

    should 'Try to create new user with already existing email_id' do
      payload = {email_id: "admin@opendoors.com"}
      user = FactoryGirl.create(:user)
      db_users = [user]
      User.expects(:where).returns(db_users)
      post "/users/", payload.to_json
      result = {user_id: user.id, new_user: false, user_details: {user_name:nil, phone_number:nil}}.to_json
      assert_equal result, last_response.body
      assert_equal last_response.status, 302
    end

    should 'Create new user' do
      payload = {email_id: "admin@opendoors.com"}
      db_users = []
      User.expects(:where).returns(db_users)
      post "/users/", payload.to_json
      assert_equal last_response.status, 201
    end

    should 'Create new user with address' do
      payload = {email_id: "admin@opendoors.com", address: {name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'}}
      db_users = []
      User.expects(:where).returns(db_users)
      post "/users/", payload.to_json
      assert_equal last_response.status, 201
    end
  end
end
