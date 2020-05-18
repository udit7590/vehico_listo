class ModelVariant < ApplicationRecord
  has_many :variants
  validates_presence_of :series
end
