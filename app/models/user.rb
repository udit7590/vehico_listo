class User < ApplicationRecord
  belongs_to :role

  validates_presence_of :first_name
end
