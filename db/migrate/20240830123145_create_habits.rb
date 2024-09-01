class CreateHabits < ActiveRecord::Migration[7.2]
  def change
    create_table :habits do |t|
      t.string :name, null: false, limit: 255
      t.date :target_date, null: false
      t.integer :target_frequency, null: false
      t.integer :target_volume

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
