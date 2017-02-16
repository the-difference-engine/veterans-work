Rails.application.routes.draw do
  devise_for :companies
  get '/companies' => 'companies#index'
  get '/companies/:id' => 'companies#show'
end
