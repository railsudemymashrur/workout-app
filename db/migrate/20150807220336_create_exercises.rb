class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.integer :duration_in_min
      t.text :workout
      t.date :workout_date
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :exercises, :users
  end
end
