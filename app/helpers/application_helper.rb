module ApplicationHelper

  # turbo_stream flashメッセージの複数表示
  def turbo_stream_flash
    turbo_stream.append "toasts", partial: "layouts/parts/toast"
  end

  # Catブログ参照スライドバー
  def sidebar_link_to(path, emoji, text)
    classes = %w[my-1 nav-link text-white]
    classes << "active" if current_page?(path)

    link_to(path, class: classes) do
      tag.span(class: "me-2") { emoji } + tag.span { text }
    end
  end

  #icon表示 
  def icon(icon_name)
    tag.i(class: ["bi", "bi-#{icon_name}"])
  end
  def icon_with_text(icon_name, text)
    tag.span(icon(icon_name), class: "me-2") + tag.span(text)
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
