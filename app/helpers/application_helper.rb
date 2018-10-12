module ApplicationHelper

  def more_wrapped(name='', options={}, &block)
    name = name+'[more]'
    toggle_text = options[:toggle_text]
    check_box_tag(name,nil,options[:checked], class: "more-state#{' show' if options[:show_check_box]}", **options) +
    label_tag(name, toggle_text || t('views.more'),
      class: "more-trigger#{' show' if toggle_text}") +
    tag.div(capture(&block), class: 'more-wrap') +
    (label_tag(name, t('views.less'), class: 'less-trigger mb-4') unless toggle_text)
  end

  def title_of_page
    return model_name(2) if action_name == 'index'
    _action_name = 'new' if action_name == 'create'
  	_action_name = 'show' if action_name == 'update'
    _action_name ||= action_name
		t _action_name, scope: [:views, :title, controller_name], default:
      t(_action_name, scope: 'views.title.action', model: model_name)
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
  end

  def controller_path(object=nil)
    public_send "#{controller_name}_path", object
  end

  def currency_precise_number(number, currency, options={})
    return nil if number.nil? || currency.nil?
    raise ArgumentError, 'Argument is not a Currency object' unless currency.is_a? Currency

    unit = options[:unit] ? currency.name : ''
    number_to_currency(number, precision: currency.precision, unit: unit)
  end

  # def format_transaction_amount(transaction, amount=nil)
  #   currency_precise_number( amount || transaction.amount, transaction.account.currency,
  #     unit: true)
  # end

  def icon(fa_symbol_name, text='')
    content_tag(:i, '', class: 'fas fa-'+fa_symbol_name)+text
  end

end
