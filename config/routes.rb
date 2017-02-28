Rails.application.routes.draw do
  devise_for :customers, :controllers => { registrations: 'customers/registrations'}
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}

  get '/' => 'pages#index'

  get '/companies/services' => 'companies#show_services'
  patch '/companies/services/:id' => 'companies#update_services'

  resources :customer_requests
  resources :companies
  resources :customers
end

