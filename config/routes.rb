Rails.application.routes.draw do
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}
  get '/' => 'pages#hello_world'

  get '/companies' => 'companies#index'
  get '/companies/:id' => 'companies#show'

  get '/requests' => 'customer_requests#index'
  get '/requests/new' => 'customer_requests#new'
  post '/requests' => 'customer_requests#create'
end
