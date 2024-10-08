class ReminderNotificationJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      today = Date.today
            user.habits.each do |habit|
        today_plan = habit.weekly_plans.find_by(start_date: today)
        if today_plan
          reminder_message = generate_reminder_message(user, habit, today_plan)
          LineNotifyService.send_message(user.uid, reminder_message) if user.uid.present?
        end
      end
    end
  end

  private

  def generate_reminder_message(user, habit, today_plan)
    "おはようございます、#{user.name}さん。\n" +
    "「#{habit.name}」の習慣目標が更新されました！\n" +
    "頻度: #{today_plan.frequency}回/週\n" +
    "時間: #{today_plan.volume}分\n" +
    "今週も頑張りましょう！"
  end
end
