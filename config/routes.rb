Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }, :skip => [:registrations, :sessions]
  get '/code-review-offers/:id', to: 'review_requests#show', as: 'code_review_offer'
  get '/code-reviews/:id', to: 'review_requests#show', as: 'code_review'
  get '/profiles/:id', to: 'users#show', as: 'profile'

  namespace :api do
    post 'offers', to: 'offers#create'
    get 'reviews', to: 'reviews#index'
    get 'review', to: 'reviews#show'
    get 'offers', to: 'offers#index'
    put 'offers', to: 'offers#update'
    post 'offers/deliver', to: 'offers#deliver'
    post 'reviews', to: 'reviews#create'
    put 'reviews', to: 'reviews#update'
    delete 'reviews/:id', to: 'reviews#destroy'
    get 'has_offered', to: 'offers#has_offered'
    get 'owned_by', to: 'reviews#owned_by'
    get 'decision_registered', to: 'offers#decision_registered'
    get 'tokens', to: 'tokens#show'
    post 'tokens', to: 'tokens#create'
  end

  devise_scope :user do
    delete '/users/sign_out', to: 'devise/sessions#destroy', as: 'destroy_user_session'
    get '/api/authorized_user' => 'users/sessions#authorized_user'
    get '/code-reviews', to: 'home#index'

    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'home#splash', as: :unauthenticated_root
    end
  end
end
