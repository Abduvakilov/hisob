# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

currency = Currency.create! name: "so‘m", code: "UZS", precision: 0 unless Currency.any?
company = Company.create! name: "Our Company" unless Company.any?
account = Account.create! name: "Primary Account", company: company, currency: currency unless Account.any?
employee = Employee.create! first_name: 'User' unless Employee.any?
user = User.create! employee: employee, login: 'user', password: 'password', password_confirmation: 'password' unless User.any?
