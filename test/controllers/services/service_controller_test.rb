require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class ServiceControllerTest < ActiveSupport::TestCase
  context 'Get slots' do
    should 'Raise Error is service is not found' do
      assert_raises(ActiveRecord::RecordNotFound) do
        get '/services/3/slots?date=2014-08-04'
      end
    end

    should 'call get slots on the service and return expected response' do
      service = FactoryGirl.create(:service)
      expected_dates = [DateTime.parse('2015-03-04 00:30:00'), DateTime.parse('2015-03-04 01:30:00')]
      expected_response = {slots: ["00:30", "01:30"]}.to_json
      Service.any_instance.expects(:get_slots).with("2015-03-04").returns(expected_dates)
      get "/services/#{service.id}/slots?date=2015-03-04"
      assert_equal expected_response, last_response.body
    end
  end
end