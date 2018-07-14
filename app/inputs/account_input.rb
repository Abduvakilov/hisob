class AccountInput < SimpleForm::Inputs::CollectionSelectInput
  def selected_account
    if selected_id = input_options[:selected]
      Account.find(selected_id)
    end
  end
  def hint(wrapper_options=nil)
    text = "Qoldiq: <b id='leftover'>%s</b>".html_safe
    if selected_account
      text % selected_account.leftover
    else
      text % '...'
    end
  end
end
