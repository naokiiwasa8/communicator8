class ApplicationFilter
  include ActiveModel::Validations
  include ActiveModel::Translation
  include Virtus.model
  # extend Enumerize
  # extend ActiveModel::Naming

  def apply(arel)
    @arel = arel
    filter
    @arel
  end

  def filter
  end

  def persisted?
    false
  end

  private
  def filter_by(attribute_name,options={})
    value = self.send(attribute_name)
    if options[:trim_space]
      value = (value.presence || '').gsub(/(\s|　)/,'')
    end
    if value.present?
      @arel = @arel.where(attribute_name => value)
    end
  end

  def filter_like(attribute_name,options={})
    value = self.send(attribute_name)
    _table_name = options[:table_name].presence || @arel.table_name
    if options[:trim_space]
      value = (value.presence || '').gsub(/(\s|　)/,'')
    end
    if value.present?
      if options[:joins].present?
        @arel = @arel.joins(options[:joins])
      end
      @arel = @arel.where("#{_table_name}.#{attribute_name} like :like_word",like_word: "%#{escape_like(value)}%")
    end
  end

  def escape_like(string)
    string.gsub(/[\\%_]@/){|m| "\\#{m}"}
  end

  def safe_date(*attr_names)
    Array(attr_names).each do |attr_name|
      self.send("#{attr_name.to_s}=",self.send(attr_name).presence || nil)
    end
  end
end