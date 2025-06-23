module ApplicationHelper
  def icon_tag(name, style: "solid", options: {})
    path = "heroicons/#{style}/#{name}.svg"
    classes = options.delete(:class)
    content_tag(:span, inline_svg_tag(path, options.merge(class: classes)), class: "icon #{classes}")
  end
end
