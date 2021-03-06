require File.expand_path(File.dirname(__FILE__) + '/../../../test_config.rb')

class ServiceTest < ActiveSupport::TestCase
  context 'Service Model' do
    should 'construct new instance' do
      @service = Service.new
      assert_not_nil @service
    end
  end

  context 'get slots' do
    should 'aggregate slots for all the veterans' do
      service = FactoryGirl.create(:service)
      FactoryGirl.create(:veteran, service: service)
      FactoryGirl.create(:veteran, service: service)
      slots1 = [DateTime.parse('2015-03-04 00:00:00'), DateTime.parse('2015-03-04 01:30:00')]
      slots2 = [DateTime.parse('2015-03-04 00:30:00'), DateTime.parse('2015-03-04 01:30:00')]
      expected_slots = [DateTime.parse('2015-03-04 00:00:00'), DateTime.parse('2015-03-04 01:30:00'), DateTime.parse('2015-03-04 00:30:00')]
      service.veterans[0].expects(:get_slots).returns(slots1)
      service.veterans[1].expects(:get_slots).with('2015-04-04').returns(slots2)
      assert_equal expected_slots, service.get_slots('2015-04-04')
    end

    should 'return empty list if no veterans found' do
      service = FactoryGirl.create(:service)
      assert_equal [], service.get_slots('2015-04-04')
    end
  end

  context "Get all services" do
    should "return all services" do
      service1_details = {name: 's1', image: 's1i.jpg', price_per_hour: "1.0"}
      service2_details = {name: 's1', image: 's1i.jpg', price_per_hour: "1.0"}
      service1 = FactoryGirl.create(:service, service1_details)
      service2 = FactoryGirl.create(:service, service2_details)
      get '/services'
      expected_response = [service1_details.merge(service_id: service1.id),
                           service2_details.merge(service_id: service2.id)]
      assert_equal expected_response, JSON.parse(last_response.body, symbolize_names: true)
    end
  end
end
