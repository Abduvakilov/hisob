module Filter

	PERIODS = %I[ today yesterday this_week prev_week this_month prev_month ]

	def filter_with(params)
		result = kept
    params.each do |field,value|
    	next if value.blank?
    	field_value = send("#{field}_filter", value) if respond_to? "#{field}_filter", true
    	result = result.joins(field_value.keys[0].to_s.singularize.to_sym) if field_value.is_a?(Hash) && field_value.values[0].is_a?(Hash)
    	result = result.where field_value || {field => value}
    end
    result
	end

	private

	def type_filter(array)
		type_ids = Transaction::ALL_TYPES.values.map &:values
		array    = array.map(&:to_i)
		{type_id: type_ids.values_at(*array).flatten}
	end

	def currency_id_filter(value)
		{accounts: {currency_id: value}}
	end

	def account_id_filter(value)
		id = value.to_i # sanitized
		"account_id=#{id} or counter_account_id=#{id}"
	end

	def datetime_filter(_id)
		period = PERIODS[_id.to_i].to_s.split('_')
		if period.length == 2
			{datetime: send(*period)}
		else
			{datetime: Date.send(*period).all_day}
		end
	end

	def this(period)
		d = DateTime.now
		d.send("beginning_of_#{period}")..d.send("end_of_#{period}")
	end

	def prev(period)
		d = DateTime.now - 1.send("#{period}")
		d.send("beginning_of_#{period}")..d.send("end_of_#{period}")
	end


end
