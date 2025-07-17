module SanitizerHelper
  def rich_text_sanitize(html)
    sanitizer = Rails::Html::WhiteListSanitizer.new

    allowed_tags = %w[b i strike a div span img]
    allowed_attributes = %w[href src alt target rel style]
    allowed_protocols = %w[http https]

    sanitizer.sanitize(html,
                       tags: allowed_tags,
                       attributes: allowed_attributes,
                       protocols: allowed_protocols
    )
  end
end
