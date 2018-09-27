require 'autocomplete_off_input'
class CurrencyInput < AutocomlpleteOff
  def input_html_options
    super.merge 'data-controller': 'currency', class: 'text-right'
  end
end
