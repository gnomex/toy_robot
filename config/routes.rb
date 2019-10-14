Rails.application.routes.draw do
  root 'robots#index'

  post 'robots/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
