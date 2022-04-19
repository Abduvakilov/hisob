class AccountInput < SimpleForm::Inputs::CollectionSelectInput
  def selected_account
    Account.find input_options[:selected] if input_options[:selected]
  end

  def hint(wrapper_options=nil)
    'Qoldiq: '.html_safe+ content_tag(:b,
      options[:balance] || '...',
      id: 'balance', 'data-account-target': 'balance')
  end

  def anchor(wrapper_options=nil)
    selected_account&.name
  end

end
