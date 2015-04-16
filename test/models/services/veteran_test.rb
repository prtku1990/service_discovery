require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class VeteranTest < ActiveSupport::TestCase
  context 'Veteran Model' do
    should 'construct new instance' do
      @veteran = Veteran.new
      assert_not_nil @veteran
    end
  end

  context 'All slots' do
    should 'return all slots for a given date' do
      expected = [DateTime.parse('2015-03-04 00:00:00'), DateTime.parse('2015-03-04 00:15:00'),
                  DateTime.parse('2015-03-04 00:30:00'), DateTime.parse('2015-03-04 00:45:00'),
                  DateTime.parse('2015-03-04 01:00:00'), DateTime.parse('2015-03-04 01:15:00'),
                  DateTime.parse('2015-03-04 01:30:00'), DateTime.parse('2015-03-04 01:45:00')]
      assert_equal expected, Veteran.all_time_slots(0, 1, '2015-03-04')
    end
  end

  context 'Get slots' do
    setup do
      @time_slots = [DateTime.parse('2015-03-04 00:00:00'), DateTime.parse('2015-03-04 00:15:00'),
                         DateTime.parse('2015-03-04 00:30:00'), DateTime.parse('2015-03-04 00:45:00'),
                         DateTime.parse('2015-03-04 01:00:00'), DateTime.parse('2015-03-04 01:15:00'),
                         DateTime.parse('2015-03-04 01:30:00'), DateTime.parse('2015-03-04 01:45:00')]
      @veteran = FactoryGirl.create(:veteran)
    end

    should 'return all time slots of the date' do
      Veteran.expects(:all_time_slots).with(9, 18, '2015-03-04').returns(@time_slots)
      assert_equal @time_slots, @veteran.get_slots('2015-03-04')
    end

    should 'return only available slots for the date' do
      FactoryGirl.create(:veteran_slot, veteran: @veteran, start_time: '2015-03-04 00:15:00', end_time: '2015-03-04 01:15:00')
      FactoryGirl.create(:veteran_slot, veteran: @veteran, start_time: '2015-03-04 01:45:00', end_time: '2015-03-04 03:45:00')
      Veteran.expects(:all_time_slots).with(9, 18, '2015-03-04').returns(@time_slots)
        assert_equal [DateTime.parse('2015-03-04 00:00:00'), DateTime.parse('2015-03-04 01:30:00')],
                   @veteran.reload.get_slots('2015-03-04')
    end
  end
end

