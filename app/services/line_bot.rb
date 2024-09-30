require 'line/bot'

class LineBot
  def initialize
    @client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def send_message(user_id, message)
    message = {
      type: 'text',
      text: message
    }
    @client.push_message(user_id, message)
  end
end