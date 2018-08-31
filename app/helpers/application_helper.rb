module ApplicationHelper

  def more_wrapped(&block)
    raw('<input type="checkbox" class="more-state" id="more"/><label for="more" class="more-trigger mb-4">' +
      t('views.more') + '</label><div class="more-wrap">' +
      capture(&block) + '</div>')
  end

  def title_of_page
    return model_name(2) if action_name == 'index'
    _action_name = 'new' if action_name == 'create'
  	_action_name = 'show' if action_name == 'update' else _action_name ||= action_name

		t _action_name, scope: [:views, :title, controller_name], default:
      t(_action_name, scope: 'views.title.action', model: model_name)
  end

  def model_name(count=1)
    controller.model.model_name.human(count: count)
  end

  def controller_path(object=nil)
    public_send "#{controller_name}_path", object
  end

  def format_transaction_amount(transaction, amount=nil)
    number_to_currency( amount || transaction.amount,
      precision: transaction.account.currency.precision,
      unit: transaction.account.currency.code) if transaction.account
  end

  def icon(fa_symbol_name, text='')
    content_tag(:i, '', class: 'fas fa-'+fa_symbol_name)+text
  end

end
