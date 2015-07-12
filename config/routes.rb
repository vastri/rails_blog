Rails.application.routes.draw do
  root 'articles#index'
  get '*path', to: 'articles#show'
end
