class LineController < ApplicationController
  protect_from_forgery with: :null_session

  def webhook
    body = request.body.read
    events = JSON.parse(body)["events"]

    events.each do |event|
      if event["type"] == "follow"
        line_user_id = event["source"]["userId"]
        User.find_or_create_by(line_user_id: line_user_id)
      end
    end

    head :ok
  end
end
