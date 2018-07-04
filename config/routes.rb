Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :transactions, except: :new do 
    collection do
      get 'new_in'
      get 'new_out'
      get 'new_inout'
      get 'new_other'
    end
  end
  resources :products, :application
end
