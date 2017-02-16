Rails.application.routes.draw do
  devise_for :companies, :controllers => { registrations: 'companies/registrations'}
  get '/' => 'pages#hello_world'

  get '/companies' => 'companies#index'
  get '/companies/:id' => 'companies#show'
end
