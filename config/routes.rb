Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#index"
  resources :transactions, :products, :counter_parties,
            :employees, :salaries, :departments, :companies,
  					:accounts, :categories, :districts, :currencies, except: :edit


end
