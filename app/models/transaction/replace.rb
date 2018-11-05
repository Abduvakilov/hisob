class Replace < Transaction

	validates_presence_of :counter_account
	validates_absence_of :counter_party, :accepted_as_amount, :accepted_as_currency, :rate, :asked_currency

  validate :account_currencies_match
  validate :different_accounts

  enum type_id: @@all_types[:replace]

  private
  def account_currencies_match
    if account.currency != counter_account.currency
      errors.add :counter_account, :currencies_does_not_match
    end
  end

  def different_accounts
    if account == counter_account
      errors.add :counter_account, :is_the_same
    end
  end

end
