class AddDateAndTimeToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :ate_meal_at, :datetime
  end
end
