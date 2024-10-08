require "net/http"
require "uri"
require "json"

class LineNotifyService
  def self.send_message(uid, message)
    uri = URI.parse("https://api.line.me/v2/bot/message/push")
    # LINEのメッセージ送信APIのエンドポイントURLを解析してURIオブジェクトを生成
    request = Net::HTTP::Post.new(uri)
    # 上で解析したURIを使ってPOSTリクエストのオブジェクトを生成
    request.content_type = "application/json"
    # リクエストのコンテンツタイプをJSONに設定
    request["Authorization"] = "Bearer #{ENV['LINE_CHANNEL_TOKEN']}"
    # 環境変数から取得したLINEチャネルトークンを使用して、認証ヘッダーを設定
    request.body = JSON.dump({
                               to: uid,
                               messages: [ { type: "text", text: message } ]
                             })
    # リクエストボディに、送信先のユーザー識別子と、送信するメッセージの内容をJSON形式で設定

    req_options = { use_ssl: uri.scheme == "https", read_timeout: 10, open_timeout: 5 }
    # リクエストオプションを設定
    # HTTPSを使用し、読み取りタイムアウトとオープンタイムアウトの値を指定
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    # 上記で設定したオプションを用いてHTTPリクエストを送信し、レスポンスを受け取る

    handle_response(response)
  end

  def self.handle_response(response)
    case response
    when Net::HTTPSuccess
      Rails.logger.info "LINE通知 送信成功"
    when Net::HTTPUnauthorized
      Rails.logger.error "LINE通知 送信失敗: 認証エラー"
    when Net::HTTPNotFound
      Rails.logger.error "LINE通知 送信失敗: リソースが見つかりません"
    else
      Rails.logger.error "LINE通知 送信失敗: #{response.code} #{response.message}"
      Rails.logger.error "レスポンスボディ: #{response.body}"
    end
  end
end
