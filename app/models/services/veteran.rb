class Veteran < ActiveRecord::Base
  include AppConstants::Veteran
  has_many :veteran_slots
  belongs_to :service

  def get_slots(date)
    avlbl_time_slots = Veteran.all_time_slots(DAY_START_HOUR, DAY_END_TIME, date)
    booked_slots = get_booked_slots(date)
    booked_slots.each do |booked_slot|
      avlbl_time_slots = remove_booked_slot(avlbl_time_slots, booked_slot)
    end
    avlbl_time_slots
  end

  # TODO:Do we want to have day start and end time at a veteran level?
  def self.all_time_slots(start_hour, end_hour, date)
    (start_hour..end_hour).collect do |hour|
      POSSIBLE_START_MINS_IN_HOUR.collect do |min|
        DateTime.parse("#{date} #{hour}:#{min}:0")
      end
    end.flatten
  end

  private
  def get_booked_slots(date)
    veteran_slots.where("date(start_time) = '#{date}'").where(is_reserved: true)
  end

  def remove_booked_slot(avlbl_time_slots, booked_slot)
    avlbl_time_slots.delete_if do |slot|
      slot >= booked_slot.start_time && slot <= booked_slot.end_time
    end
    avlbl_time_slots
  end
end