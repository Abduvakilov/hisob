Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :transactions, except: :new do 
    collection do
      get 'new_in'
      post 'create_in'

      get 'new_out'
      post 'create_out'

      get 'new_inout'
      post 'create_inout'

      get 'new_other'
      post 'create_other'
    end
  end
  resources :application, :products, :counter_parties, :accounts
end
