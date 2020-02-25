class Meal < ApplicationRecord
  belongs_to :user
  validates_presence_of :calories, numericality: {greater_than: 0}
  validates_presence_of :ate_meal_at

  def ate_meal_at_date
    self.ate_meal_at.strftime('%d/%m/%Y')
  end

  def ate_meal_at_time
    self.ate_meal_at.strftime('%H:%M')
  end
end
