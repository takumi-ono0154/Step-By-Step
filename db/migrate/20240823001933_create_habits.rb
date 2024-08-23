class CreateHabits < ActiveRecord::Migration[7.2]
  def change
    create_table :habits do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.date :target_date, null: false
      t.integer :target_frequency, null: false
      t.integer :target_volume

      t.timestamps
    end

    add_foreign_key :habits, :users
  end
end
