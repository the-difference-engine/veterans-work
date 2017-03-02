Rails.application.routes.draw do
  devise_for :customers, :controllers => { registrations: 'customers/registrations'}
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}

  get '/' => 'pages#index'

  get '/companies/customer_reviews' => 'customer_reviews#new'
  post '/companies/customer_reviews' => 'customer_reviews#create'

  resources :customer_requests
  resources :companies
  resources :customers
end

