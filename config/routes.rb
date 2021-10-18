Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  resources :projects, only: [:index, :new, :create, :show,] do
    get 'my_projects', on: :collection
    resources :proposals, only: [:show, :create] do
        post 'accept', on: :member
        post 'reject', on: :member
    end
  end
  
  get 'search', to: 'projects#search'
  get 'my_proposals', to:'proposals#my_proposals'
  

  devise_for :project_owners, path: 'project_owners'
  devise_for :freelancers, path: 'freelancers'

  resources :profiles, only: [:show, :edit, :update]
end
