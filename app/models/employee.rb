class Employee < ApplicationRecord

  enum gender: { male: true, female: false }

  validates_presence_of :first_name, unless: -> { last_name.present? }
  validates_presence_of :last_name, unless: -> { first_name.present? }

  def to_s
    full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.shown_fields
     %I[first_name last_name birthday department gender hire_date notes]
  end

  belongs_to :department, optional: true
  belongs_to :company, optional: true
  has_many :salaries
  has_one :user

end
