require File.expand_path(File.dirname(__FILE__) + '/../../../test_config.rb')

class VeteranSlotTest < ActiveSupport::TestCase
  context 'VeteranSlot Model' do
    should 'construct new instance' do
      @veteran_slot = VeteranSlot.new
      assert_not_nil @veteran_slot
    end
  end
end
