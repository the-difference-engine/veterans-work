Rails.application.routes.draw do
  devise_for :companies
  get '/' => 'pages#hello_world'
end
