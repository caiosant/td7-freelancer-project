Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  resources :projects, only: [:new, :create, :show,]

  devise_for :project_owners, path: 'project_owners'
  devise_for :freelancers, path: 'freelancers'
end
