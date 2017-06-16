Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'reviews/create'
    end
  end

  devise_for :admins
  devise_for :customers, :controllers => { registrations: 'customers/registrations'}
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}

  get '/' => 'pages#index'
  get '/about' => 'pages#about'
  get '/how' => 'pages#how'
  get '/admin_panel' => 'pages#admin_panel'

  resources :admins
  resources :customer_requests
  resources :companies
  resources :customers
  resources :reviews
  resources :quotes
  resources :contracts

  namespace :api do
    namespace :v1 do
      post '/reviews' => 'reviews#create'
    end
  end
end

