module ApplicationHelper
  def icon_tag(name, style: "solid", options: {})
    path = "heroicons/#{style}/#{name}.svg"
    classes = options.delete(:class)
    size = options[:size] || nil
    css_styles = size ? "width: #{size}px; height: #{size}px;" : nil
    content_tag(:span, inline_svg_tag(path, options.merge(class: classes)), class: "icon #{classes}", style: css_styles)
  end

  def p_tag(name, classes:)
    content_tag(:p, name, class: "#{classes}")
  end
end
