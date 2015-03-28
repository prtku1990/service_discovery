class Address < ActiveRecord::Base
  belongs_to :customer
  has_many :order
end
