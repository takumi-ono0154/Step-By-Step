# config/schedule.rb
every :monday, at: '8:00 am' do
  runner "LineBot.send_weekly_message"
end
