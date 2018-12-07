class Employee < ApplicationRecord

  enum gender: { male: true, female: false }

  validates_presence_of :first_name, unless: :last_name?
  validates_presence_of :last_name,  unless: :first_name?

  def to_s
    full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.shown_fields
     %w[first_name last_name birthday department gender hire_date notes]
  end

  belongs_to :department, optional: true
  belongs_to :company
  has_many   :salaries,   -> { kept }
  has_one    :user,       -> { kept }

end
