class Meal < ApplicationRecord
  belongs_to :user
  validates_presence_of :calories, numericality: {greater_than: 0}
end
