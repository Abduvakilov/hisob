require 'autocomplete_off_input'
class DatepickerInput < AutocomlpleteOff
  def input_html_options
    super.merge 'data-controller': 'flatpickr'
  end
end
