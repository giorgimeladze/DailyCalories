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

  def ate_meal_at_year
    self.ate_meal_at.strftime('%Y')
  end

  def ate_meal_at_month
    self.ate_meal_at.strftime('%m')
  end

  def ate_meal_at_day
    self.ate_meal_at.strftime('%d')
  end

  def ate_meal_at_hour
    self.ate_meal_at.strftime('%H')
  end

  def ate_meal_at_minute
    self.ate_meal_at.strftime('%M')
  end
end
