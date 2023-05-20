module ApplicationHelper
  include IconWithAttr

  # turbo_stream flashメッセージの複数表示
  def turbo_stream_flash
    turbo_stream.append "toasts", partial: "layouts/parts/toast"
  end

  #icon・画像の表示 
  def icon(icon_name)
    tag.i(class: ["bi", "bi-#{icon_name}"])
  end
  def icon_with_text(icon_name, text = nil)
    text ||= icon_name
    tag.span(icon(icon_name), class: "me-3") + tag.span(text)
  end

  def image_with_text(image_path, text = nil)
    text ||= File.basename(image_path, '.*')
    content_tag(:span, class: 'image-text') do
      concat image_tag(image_path)
      concat ' '
      concat text
    end
  end
  

  # svgファイル表示
  def embedded_svg(filename, options={})
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end
end
