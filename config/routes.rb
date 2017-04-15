Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers, :controllers => { registrations: 'customers/registrations'}
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}

  get '/' => 'pages#index'
  get '/about' => 'pages#about'
  get '/admin_panel' => 'pages#admin_panel'

  resources :admins
  resources :customer_requests
  resources :companies
  resources :customers
  resources :reviews
  resources :quotes
end

