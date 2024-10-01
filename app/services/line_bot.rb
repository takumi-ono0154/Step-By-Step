require 'line/bot'

class LineBot
  def self.send_weekly_message
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET'] # 環境変数から取得
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']   # 環境変数から取得
    }

    # line_user_idが存在するユーザーのIDリストを取得
    user_ids = User.where.not(line_user_id: nil).pluck(:line_user_id)

    user_ids.each do |user_id|
      message = {
        type: 'text',
        text: 'おはようございます、今週の目標を確認しましょう！(https://portfolio-twnh.onrender.com)'
      }

      begin
        client.push_message(user_id, message)
      rescue StandardError => e
        Rails.logger.error("Failed to send message to #{user_id}: #{e.message}")
      end
    end
  end
end
