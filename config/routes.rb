Rails.application.routes.draw do
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}
  get '/companies' => 'companies#index'
  get '/companies/:id' => 'companies#show'

  get '/customer_requests' => 'customer_requests#index'
  get '/customer_requests/new' => 'customer_requests#new'
  post '/customer_requests' => 'customer_requests#create'
end
