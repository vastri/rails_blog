Rails.application.routes.draw do
  root 'main#home'

  get 'main/home'
  get 'main/about'
end
