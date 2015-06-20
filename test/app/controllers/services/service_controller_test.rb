require File.expand_path(File.dirname(__FILE__) + '/../../../test_config.rb')

class ServiceControllerTest < ActiveSupport::TestCase
  context 'Get slots' do
    should 'Raise Error is service is not found' do
      assert_raises(ActiveRecord::RecordNotFound) do
        get '/services/3/slots?date=2014-08-04'
      end
    end

    should 'call get slots on the service and return expected response' do
      service = FactoryGirl.create(:service)
      expected_dates =
      {
          service_id: 1,
          date: "2015-06-21",
          start_times: [
          {
              start_time: "09:00:00",
          available: true
        }]
      }
          expected_response = {slots: expected_dates}.to_json
      Service.any_instance.expects(:get_all_slots).returns(expected_dates)
      get "/services/#{service.id}/slots?date=2015-03-04"
      assert_equal expected_response, last_response.body
    end
  end
end