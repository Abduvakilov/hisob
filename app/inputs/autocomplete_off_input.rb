class AutocomlpleteOff < SimpleForm::Inputs::StringInput
  def input_html_options
  	super.merge autocomplete: :off
  end
end