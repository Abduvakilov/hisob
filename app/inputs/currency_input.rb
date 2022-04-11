class CurrencyInput < AutocompleteOffInput
  def input_html_options
    super.merge 'data-controller': 'currency', class: 'text-right'
  end
end
