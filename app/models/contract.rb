class Contract < ActiveRecord::Base

  scope :ordered, -> {}
  scope :in_date, -> (date=Date.today) {
    where(':date between ifnull(start_date, subdate(:date,1)) and
      ifnull(due_date, :date+interval 1 day)', date: date)
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
    Contract.kept.where(counter_party_id: counter_party_id)
  end

  def single?
    Contract.kept.where(counter_party_id: counter_party_id).count('id') == 1
  end

  def expired?
    due_date? && due_date < Date.today
  end

  def to_s
    name + ', ' + currency
  end

  belongs_to :category, optional: true
  belongs_to :counter_party
  belongs_to :currency

  has_many :sales
  has_many :purchases

end
