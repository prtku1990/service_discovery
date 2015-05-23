require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class UserControllerTest < ActiveSupport::TestCase
  # context "UserServicesController" do
  #   setup do
  #     get '/'
  #   end
  #
  #   should "return hello world text" do
  #     assert_equal "Hello World", last_response.body
  #   end
  # end
  #
  # # def get_create_address_params
  # #   @input = parse_request
  # #   validates_presence_of :name, :line1, :line2, :city, :state, :pincode , :phone_number
  # # end
  #
  # should 'Return error if start_time is not present in request' do
  #   payload = {service_id: 1, address_id: 1}
  #   assert_raises StandardError.new('Parameter start_time is mandatory') do
  #     post '/orders', payload.to_json
  #   end
  # end
  #
  #
  # # context 'AddAddress' do
  # #   should 'Return error if name is not present in request' do
  # #     payload = {name: 'santhosh', line1: 'first line', line2: 'second line', city: 'blore', state: 'KA', pincode: '532421', phone_number: '9538255159'}
  # #     assert_raise StandardError.new('Name is mandaroty') do
  # #       post ''
  # #     end
  # #   end
  # # end
end
