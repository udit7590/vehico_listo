class Make < ApplicationRecord
  has_many :vehicles

  validates_presence_of :name
end
