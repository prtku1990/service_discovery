class Service < ActiveRecord::Base
  has_many :veterans

  def get_slots(date)
    veterans.each_with_object([]) do |veteran, slots|
      slots.concat(veteran.get_slots(date)).uniq!
    end
  end
end