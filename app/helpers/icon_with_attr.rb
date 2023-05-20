module IconWithAttr
  ICONS = {
    # user
    user_name: 'bi bi-person-circle',
    # profile
    job_title: 'bi bi-person-workspace',
    years_of_experience: 'bi bi-code-slash',
    company: 'bi bi-building',
    birthday: 'bi bi-calendar3-event',
    biography: 'bi bi-person-badge'
  }.freeze

  def icon_with_attr(model, key)
    icon_class = ICONS[key.to_sym]
    text = t("activerecord.attributes.#{model}.#{key}")

    content_tag(:span, class: 'icon-text') do
      concat content_tag(:i, '', class: icon_class)
      concat ' '
      concat text
    end
  end
end
