class User < ApplicationRecord
  belongs_to :employee
  validates :login, uniqueness: true

  def self.permitted_params
     self.shown_fields + %I[password password_confirmation]
  end

  def password_required?
    return false unless login.present?
    super
  end

  def email_required?; false end
  def will_save_change_to_email?; false end
  def password_required?
    password.present?
  end
  def will_save_change_to_password?
    password.present?
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :lockable, :trackable,
         :rememberable, :validatable, :timeoutable

end
