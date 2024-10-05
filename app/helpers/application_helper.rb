module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice
      "bg-green-400"  # 成功メッセージ
    when :alert
      "bg-red-500"    # 警告メッセージ
    when :error
      "bg-yellow-500" # エラーメッセージ
    else
      "bg-gray-500"   # その他
    end
  end

  # Deviseのフラッシュメッセージに対応する背景色を取得するメソッドを追加
  def devise_flash_background_color(type)
    case type.to_sym
    when :signed_in, :signed_out, :updated, :signed_up
      "bg-green-500"  # 成功メッセージ
    when :already_signed_out, :not_found, :not_locked, :already_confirmed
      "bg-yellow-500" # 注意メッセージ
    when :invalid, :inactive, :locked, :unconfirmed
      "bg-red-500"    # エラーメッセージ
    else
      flash_background_color(type) # その他はデフォルトの色を使用
    end
  end
end
