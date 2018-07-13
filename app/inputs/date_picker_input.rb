require 'autocomplete_off_input'
require 'date'
class DatePickerInput < AutocomlpleteOff
	def input_html_options
		super.merge ({
			'type': 'text',
			# 'data-date-format': 'dd.mm.yy',
			# 'data-auto-close': 'true',

		})
	end
  # def input_html_classes
    # super.push 'datepicker-here'
  # end
end