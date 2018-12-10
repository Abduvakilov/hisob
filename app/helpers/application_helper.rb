module ApplicationHelper

  def more_wrapped(name='', options={}, &block)
    name = name.to_s+'[more]'
    toggle_text = options[:toggle_text]
    check_box_tag(name,nil,options[:checked], class: "more-state#{' show' if options[:show_check_box]}", **options) +
    label_tag(name, toggle_text || t('views.more'),
      class: "more-trigger#{' show' if toggle_text}") +
    tag.div(capture(&block), class: 'more-wrap') +
    (label_tag(name, t('views.less'), class: 'less-trigger mb-4') unless toggle_text)
  end

  def title_of_page
    _model_name = (controller.try(:parent_class)&.model_name&.human || model_name(2)) if action_name == 'index'
    _action_name = 'new' if action_name == 'create'
  	_action_name = 'show' if action_name == 'update'
    _action_name ||= action_name
		t _action_name, scope: [:views, :title, controller_name], default: (_model_name || model_name)
  end

  def title_for(path)
    controller, action = Rails.application.routes.recognize_path(path).values
    t action, scope: [:views, :title, controller]
  end

  def bootstrap_alert(key)
    case key
    when 'alert', 'error'
      'danger'
    when 'notice'
      'success'
    else key
    end
  end

  def model_name(count=1)
    controller.model&.model_name&.human(count: count)
  rescue NoMethodError
    nil
  end

  def currency_precise_number(number, currency, options={})
    return nil if number.nil? || currency.nil?
    raise ArgumentError, 'Argument is not a Currency object' unless currency.is_a? Currency

    unit = options[:unit] ? currency.name : ''
    number_to_currency(number, precision: currency.precision, unit: unit)
  end

  def user_default_time
    Time.now + current_user.default_day_difference.days
  end

  def user_default_date
    Date.today + current_user.default_day_difference
  end

  def icon(fa_symbol_name, text=nil)
    content_tag(:i, '', class: 'fas fa-'+fa_symbol_name)+(' '+text unless text.nil?)
  end

  def color_pay_receive(number, currency, options={})
    formatted_number = currency_precise_number(number, currency, **options)
    raw content_tag(options[:tag]||:span, formatted_number||number,
      class: (number>0 ? 'text-success' : (number<0 ? 'text-danger' : 'text-muted'))).html_safe
  end

end
