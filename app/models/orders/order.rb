class Order < ActiveRecord::Base
  belongs_to :address
  belongs_to :service
  validates_presence_of :service, :address
end
