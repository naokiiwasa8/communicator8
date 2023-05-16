module DataCardHelper
  def card_value(object,method,options={})
    DataCardItem.new(object,method,options).value.html_safe
  end
  def card_item(object,method,options={})
    item = DataCardItem.new(object,method,options)

    formatter = options.delete(:formatter) || :list_group_item
    case formatter
    when :list_group_item
      content_tag(:div,class: "list-group-item card-item") do
        tag.div(class: 'row') do
          tag.label(item.label,class: "col-sm-3 card-item-label") +
          tag.div(item.value.html_safe,class: "col-sm-9")
        end
      end
    when :list_group_item_colored
      content_tag(:div,class: "list-group-item card-item bg-secondary") do
        tag.div(class: 'row') do
          tag.label(item.label,class: "col-sm-3 card-item-label") +
          tag.div(item.value.html_safe,class: "col-sm-9")
        end
      end
    when :vertical
      value_class = ['card-item-value']
      value_class << "card-item-value-#{options[:as] || 'default'}"
      content_tag(:div,class: "card-item") do
        content_tag(:div,item.label,class: "card-item-label mb-1") +
        content_tag(:div,item.value.html_safe,class: value_class.join(" "))
      end
    when :horizontal
      content_tag(:div,class: "row card-item-row") do
        content_tag(:label,item.label,class: "control-label card-item-label col-sm-3") +
        content_tag(:div,item.value.html_safe,class: "col-sm-9 card-item-value #{options[:class]}")
      end
    when :table
      content_tag(:th,item.label,class: "#{options[:th_class]}") + content_tag(:td,item.value.html_safe)
    when :dl
      content_tag(:dt,item.label,class: "") +
      content_tag(:dd,item.value.html_safe,class: "#{options[:class]}")
    when :none
      item.value.html_safe
    end
  end

  class DataCardItem
    attr_accessor :label
    attr_accessor :value
    include ActionView::Helpers
    include ApplicationHelper
    include Rails.application.routes.url_helpers


    def initialize(object,method,options={})
      @options = options
      if object.respond_to?(method)
        value = object.send(method)

        if value.present? || !value.nil?
          case @options[:as]
          when :email
            value = mail_to(value,value,reply_to: Settings.support_address).html_safe
          when :password
            value = "＊" * value.size
          when :date
            value = Date.parse(value) unless value.is_a?(Date)
            value = localize(value,format: (@options[:date_format].presence || :long))
          when :datetime
            value = Time.parse(value) unless value.is_a?(Time)
            value = localize(value,format: :medium)
          when :time
            value = Time.parse(value) unless value.is_a?(Time)
            value = localize(value,format: (@options[:time_format].presence || :short))
          when :date_range
            value = value.map{|v|localize(v,format: (options[:date_format].presence || :long))}.join("〜")
          when :time_range
            value = value.map{|v|localize(v,format: :micro)}.join("〜")
          when :currency
            value = number_to_currency(value)
          when :delimiter
            value = number_with_delimiter(value)
          when :text
            value = simple_format(value)
          when :json
            value = tag.pre(JSON.pretty_generate(value))
          when :codemirror_json
            dom_id = SecureRandom.hex
            js_src = <<-END_SRC.strip_heredoc
              var jsEditor = CodeMirror.fromTextArea(document.getElementById('#{dom_id}'), {
                  mode: 'application/ld+json',
                  theme: 'yeti',
                  lineNumbers: true,
                  readOnly: true,
                  indentUnit: 40,
                  indentWithTabs: false,
                  electricChars: true,
                  withBrackets: true,
                  json: true
              });
            END_SRC
            value = [
                      text_area_tag(dom_id,JSON.pretty_generate(value),class: 'codemirror-json form-control',rows: 10),
                      javascript_tag(js_src)
                    ].join.html_safe
          when :boolean
            value = (value ? content_tag(:i,'',class: "fa fa-check text-success") : content_tag(:i,'',class: "fa fa-times text-danger"))
          when :enum
            value = object.send("#{method.to_s}_text")
          when :array
            value = value.join("、")
          when :map
            value = object.map{|v|v.send(method)}.join("、")
          when :date_range
            value = value.map{|v|localize(v,format: :long)}.join("〜")
          when :check
            if value
              value = '<span class="text-success"><i class="fa fa-check"></i></span>'.html_safe
            else
              value = '<span class="text-danger"><i class="fa fa-ban"></i></span>'.html_safe
            end
          when :belongs_to
            _label_method = options[:label_method].presence || :name
            value = object.send(method).send(_label_method)
          when :preview
            value = image_tag(@options.delete(:image_path),@options)
          when :coop_number
            value = value.rjust(12)
            value = [value[0..3],value[4..7],value[8..11]].join('-')
          when :look_up
            value = look_up_tag(object.send(method.to_s),options[:text]).html_safe
          when :proxy
            value = if value
              tag.strong('代行',class: 'text-purple')
            else
              tag.strong('Web',class: 'text-orange')
            end
          when :done
            value = if value
              tag.span('済',class: 'badge bg-success')
            else
              tag.span('未',class: 'badge bg-danger')
            end

          when :do
            value = if value
              tag.span('する',class: 'badge bg-success')
            else
              tag.span('しない',class: 'badge bg-danger')
            end

          when :link
            _link_text = options[:link_text].presence || value
            value = link_to(_link_text,value,target: '_blank').html_safe
          end
        else
          value = nil
        end
      elsif (options[:as].presence || '') == :map
        value = object.map{|v|v.send(method)}.join("、")
      else
        value = nil
      end
      if value.present?
        @value = "#{options[:prefix]}#{value}#{options[:suffix]}".html_safe
      else
        @value = "−−−−−"
      end
      if options[:cancel]
        @value = [tag.del(@value,class: "text-danger"),tag.span('キャンセルされています',class: 'text-danger')].join('<br>').html_safe
      end
      if options[:link].present?
        @value = link_to(@value,options[:link],(options[:link_options] || {}))
      end

      label = options.delete(:label)
      if options[:as] == :map
        label ||= object.first.try(:human_attribute_name,method)
      elsif options[:as] == :belongs_to
        if (_label_method = options[:label_method]).present?
          label ||= object.send(method).class.human_attribute_name(_label_method) rescue nil
        else
          label ||= method.to_s.classify.constantize.model_name.human
        end
      else
        label ||= object.class.try(:human_attribute_name,method)
      end
      @label = label
    end
  end
end
