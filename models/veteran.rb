class Veteran < ActiveRecord::Base
  belongs_to :service
  has_many :veteran_slot
end
