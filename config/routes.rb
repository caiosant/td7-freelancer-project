Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"
  devise_for :project_owners, path: 'project_owners'
  devise_for :freelancers, path: 'freelancers'

  resources :projects, only: [:index, :new, :create, :show,] do
    
    resources :freelancers do
      resources :freelancer_feedbacks, only: [:new, :create, :show]
    end

    resources :proposals, only: [:show, :create] do
      post 'accept', on: :member
      post 'reject', on: :member
      post 'cancel', on: :member

      resources :proposal_cancelations, only: [:new, :create]
    end

    get 'my_projects', on: :collection
    post 'finish', on: :member
  end

  resources :profiles, only: [:show, :edit, :update] do
    resources :freelancers_favorites, only: [:create, :destroy]
  end
  
  get 'search', to: 'projects#search'
  get 'my_proposals', to:'proposals#my_proposals'
end
