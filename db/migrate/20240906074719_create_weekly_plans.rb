class CreateWeeklyPlans < ActiveRecord::Migration[7.2]
  def change
    create_table :weekly_plans do |t|
      t.references :habit, null: false, foreign_key: true
      t.integer :week, null: false
      t.integer :frequency, null: false
      t.integer :volume, null: true

      t.timestamps
    end
  end
end
