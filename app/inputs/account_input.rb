class AccountInput < SimpleForm::Inputs::CollectionSelectInput
  def selected_account
    if selected_id = input_options[:selected]
      Account.find(selected_id)
    end
  end
  def hint(wrapper_options=nil)
    text = "Hisob valyutasi: <b id='currency'>%s</b>,<br>
       Hisobdagi qoldiq: <b id='leftover'>%s</b>".html_safe
    if selected_account
      text % [selected_account.currency.name, selected_account.leftover]
    else
      text % ['...', '...']
    end
  end

  def input_html_classes
    super.push('account')
  end
end
