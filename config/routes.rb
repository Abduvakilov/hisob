Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  concern :discardable do
    post 'discard', on: :member
  end

  resources :transactions, :products, :counter_parties, :units,
            :purchases, :productions, :sales, :prices,
            :employees, :users, :departments, :companies,
            :salaries, :payrolls,
            :accounts, :categories, :districts, :currencies,
            # :price_types, :expense_types,
  except: [:edit, :destroy],
  concerns: :discardable do
    member do
      post 'report'
      get 'new_report'
    end
  end

  resources :counter_parties, only: [] do
    resources :contracts, concerns: :discardable,
    on: :member, except: [:edit, :destroy]
  end

  resources :products, only: [], module: :nested do
    resources :prices, concerns: :discardable,
    on: :member, except: [:edit, :destroy]
  end

  match 'settings', to: 'users#settings', via: [:get, :patch]

end
