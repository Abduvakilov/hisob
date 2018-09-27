Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#index"
  resources :transactions, :products, :counter_parties,
            :employees, :salaries, :departments, :companies,
  					:accounts, :categories, :districts, :currencies,
  except: [:edit, :destroy] do
    member do
      post 'discard'
    end
  end



end
