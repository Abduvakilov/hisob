class Income < Transaction

  validates_absence_of :rate, :asked_currency, :employee

	enum type_id: ALL_TYPES[:income]

end
