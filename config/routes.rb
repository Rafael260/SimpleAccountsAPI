Rails.application.routes.draw do
  resources :accounts
  resources :people

  put '/accounts/debit/:id', to: 'accounts#debit'
  put '/accounts/credit/:id', to: 'accounts#credit'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
