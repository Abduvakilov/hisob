# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Currency.any?
  currency = Currency.create! name: "so‘m", code: "UZS", precision: 0, is_main: true
  currency2 = Currency.create! name: "$", code: "USD", precision: 2
end
company = Company.create! short_name: "Our Company" unless Company.any?
department = Department.create! name: "Management", company: company unless Department.any?
category = Category.create! name: "Wholesale" unless Category.any?
unless Account.any?
  account = Account.create! name: "Primary Account", company: company, currency: currency
  account2 = Account.create! name: "Secondary Account", company: company, currency: currency2
end
district = District.create! name: "Toshkent" unless District.any?
unless CounterParty.any?
  customer = CounterParty.create! short_name: 'KinoMarket', primary_person: 'Abdupattoh Akbarov', company_name: 'KinoMarket MCHJ', phone: '998889988', email: 'kino@market.uz', is_customer: true, district: district
  supplier = CounterParty.create! short_name: 'MebelMaks', primary_person: 'Said Rasulov', company_name: 'MebelMaks MCHJ', phone: '907770123', email: 'mebelzor@rambler.uz', is_supplier: true, district: district
end
unless Unit.any?
  unit = Unit.create! long_name: "dona", short_name: "dona"
  unit2 = Unit.create! long_name: "gramm", short_name: "g"
  unit3 = Unit.create! long_name: "kilogramm", short_name: "kg", base_unit: unit2, ratio_to_base_unit: 1000
end
unless Product.any?
  product = Product.create! name: 'Stul', unit: unit
  product2 = Product.create! name: 'Oyna', company: company, unit: unit3, include_base_unit: true, is_for_sale: true
end
employee = Employee.create! first_name: 'Asad', last_name: 'Sa’dullayev', birthday: 25.years.ago, hire_date: 3.years.ago, gender: :male, company: company, department: department unless Employee.any?
user = User.create! employee: employee, login: 'admin', password: 'password', password_confirmation: 'password', is_admin: true unless User.any?
