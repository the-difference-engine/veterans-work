Rails.application.routes.draw do
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}
  get '/companies' => 'companies#index'
  post '/companies' => 'companies#create'
  get '/companies/:id' => 'companies#show'
  get '/companies/:id/edit' => 'companies#edit'
  patch '/companies/:id' => 'companies#update'
  delete '/companies/:id' => 'companies#destroy'


  resources :customer_requests
end

