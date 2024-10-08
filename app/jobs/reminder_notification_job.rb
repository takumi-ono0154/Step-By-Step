class ReminderNotificationJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      reminder_message = generate_reminder_message(user)
      LineNotifyService.send_message(user.uid, reminder_message) if user.uid.present?
    end
  end

  private

  def generate_reminder_message(user)
    "こんにちは、#{user.name}さん。今日のタスクを忘れずにチェックしてくださいね！"
  end
end
