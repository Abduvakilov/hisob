class User < ApplicationRecord

  composed_of :hi
  belongs_to :employee
  validates  :login, uniqueness: true

  DEFAULT_SETTINGS = {
    default_day_difference: 0, homepage: '',
    allow_negative_account_balance: false,
    allow_negative_product_balance: false
  }

  store :settings,
    accessors: DEFAULT_SETTINGS.keys,
    coder: JSON

  DEFAULT_SETTINGS.each do |key, def_value|
    define_method(key) {
      settings[key] or def_value
    }

    case def_value
    when TrueClass, FalseClass
      type = ActiveModel::Type::Boolean
    when Integer
      type = ActiveModel::Type::Integer
    else
      type = ActiveModel::Type::String
    end

    define_method("#{key}=") { |value|
      if value.present?
        settings[key] = type.new.cast(value)
      else
        settings.delete(key)
      end
    }
  end

  def to_s
    employee
  end

  def self.shown_fields
    %w[ employee login ]
  end

  def self.permitted_params
     %w[ employee_id login password password_confirmation
      default_day_difference
      negative_account_balance_allowed?
      negative_product_balance_allowed? ]
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
  def active_for_authentication?
    super and discarded_at == nil
  end
  def discard
    return false if is_admin
    super
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :lockable, :trackable,
         :rememberable, :validatable, :timeoutable

end
