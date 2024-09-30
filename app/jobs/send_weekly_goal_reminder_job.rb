class SendWeeklyGoalReminderJob
  include Sidekiq::Worker

  def perform
    users = User.all # 友だち登録したユーザーを取得 (必要に応じてスコープを絞る)

    line_bot = LineBot.new
    users.each do |user|
      line_bot.send_message(user.line_user_id, "今週の目標を確認しましょう!(https://portfolio-twnh.onrender.com)")
    end
  end
end