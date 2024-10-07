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

  def default_meta_tags
    {
      site: 'Step By Step',
      title: '習慣化が苦手な人をサポートするアプリ',
      reverse: true,
      charset: 'utf-8',
      description: '習慣を身につける過程で挫折しがちな方に向けて、無理のないスケジュールを提案し目標達成をサポートします。',
      keywords: '習慣',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      }
    }
  end
end
