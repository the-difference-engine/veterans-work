Rails.application.routes.draw do
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}

  get '/companies/services' => 'companies#show_services'
  patch '/companies/services/:id' => 'companies#update_services'

  resources :customer_requests
  resources :companies
end

