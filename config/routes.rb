Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign_up' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#index"

  concern :discardable do
    member do
      post 'discard'
    end
  end

  resources :transactions, :products, :counter_parties, :units,
            :purchases, :productions, :sales, :prices,
            :employees, :users, :salaries, :departments, :companies,
  					:accounts, :categories, :districts, :currencies,
  except: [:edit, :destroy],
  concerns: :discardable do
    member do
      match 'report', via: [:get, :post]
    end
  end

  resources :counter_parties, only: [] do
    resources :contracts, concerns: :discardable,
    on: :member, except: [:edit, :destroy]
  end

  resources :products, only: [] do
    resources :prices, concerns: :discardable,
    on: :member, except: [:edit, :destroy], controller: 'prices_nested'
  end


end
