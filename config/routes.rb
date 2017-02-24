Rails.application.routes.draw do
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}

  resources :customer_requests
  resources :companies
end

