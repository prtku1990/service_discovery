class Service < ActiveRecord::Base
  has_many :veterans

  def get_slots(date)
    veterans.each_with_object([]) do |veteran, slots|
      slots.concat(veteran.get_slots(date)).uniq!
    end
  end

  def get_all_slots
    ((Date.current + 1.days)..(Date.current + 7.days)).collect do |date|
      {service_id: id, date: date.to_s,
       start_times: collect_slots_for_date(date)}
    end
  end

  def as_json(options = {})
    super(options).tap do |json|
      json[:service_id] = id
    end
  end

  private
  def collect_slots_for_date(date)
    get_slots(date).collect do |slot|
      {start_time: slot.strftime('%T'), available: true}
    end
  end
end