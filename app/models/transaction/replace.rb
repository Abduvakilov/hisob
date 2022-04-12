class Replace < Transaction

	validates_absence_of :counter_party, :accepted_as_amount,
    :accepted_as_currency, :asked_currency

  validates_presence_of :account, :counter_account
  validate :account_currencies_match
  validate :different_accounts

  enum type_id: ALL_TYPES[:replace]

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
