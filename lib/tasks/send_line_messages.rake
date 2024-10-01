namespace :send_line_messages do
  desc "Send weekly messages to users"
  task send: :environment do
    users = User.where.not(line_user_id: nil)
    users.each do |user|
      # メッセージを送信するためのコード (Line Bot API を使用)
      LineClient.push_message(user.line_user_id, {
        type: "text",
        text: "おはようございます、今週の目標を確認しましょう！(https://portfolio-twnh.onrender.com)"
      })
    end
  end
end
