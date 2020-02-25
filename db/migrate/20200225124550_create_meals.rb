class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.text :name
      t.decimal :calories
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
