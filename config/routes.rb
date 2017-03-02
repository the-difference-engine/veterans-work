Rails.application.routes.draw do
  devise_for :customers, :controllers => { registrations: 'customers/registrations'}
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}

  get '/' => 'pages#index'

  get '/reviews/new' => 'reviews#new'
  post '/reviews' => 'reviews#create'

  resources :customer_requests
  resources :companies
  resources :customers
end

