json.extract! habit, :id, :user_id, :name, :target_date, :target_frequency, :target_volume, :created_at, :updated_at
json.url habit_url(habit, format: :json)
