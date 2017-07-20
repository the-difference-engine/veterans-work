Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/reviews/new' => 'reviews#new'
      post '/reviews' => 'reviews#create'
    end
  end

  devise_scope :admins do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new", as: "new_admin_registration" # custom path to sign_up/registration
  end

  devise_for :admins, :skip => [:registrations]
  as :admin do
    get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'
    put 'admins' => 'devise/registrations#update', :as => 'admin_registration'
  end

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
end

