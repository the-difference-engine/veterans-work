Rails.application.routes.draw do
  devise_for :customers, :controllers => { registrations: 'customers/registrations'}
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}

  get '/' => 'pages#index'



  resources :customer_requests
  resources :companies
  resources :customers
  resources :reviews
  resources :quotes
end

