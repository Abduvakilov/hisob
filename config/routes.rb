Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign_up' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#index"
  resources :transactions, :products, :counter_parties,
            :purchases, :productions, :sales,
            :employees, :users, :salaries, :departments, :companies,
  					:accounts, :categories, :districts, :currencies,
  except: [:edit, :destroy] do
    member do
      post 'discard'
    end
  end



end
