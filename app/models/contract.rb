class Contract < ActiveRecord::Base

  scope :ordered, -> {}
  scope :in_date, -> (date=Date.today) {
    where(':date between coalesce(start_date, :day_before) and coalesce(due_date, :day_after)',
      date: date,
      day_before: date.yesterday,
      day_after: date.tomorrow
    )
  }

  def in_date?(date=Date.today)
    after_start = start_date? ? start_date <= date : true
    before_end  = due_date?   ? due_date   >= date : true
    after_start && before_end
  end

  include Discard::Model
  extend Table::Fields
  extend Table::Sort

  def with_others
    Contract.kept.in_date.where(counter_party_id: counter_party_id)
  end

  def single?
    with_others.one?
  end

  def to_s
    name + ', ' + currency
  end

  belongs_to :price_type, class_name: 'Category'
  belongs_to :counter_party
  belongs_to :currency

  has_many :sales,     -> { kept }
  has_many :purchases, -> { kept }

end
