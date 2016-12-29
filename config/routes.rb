Rails.application.routes.draw do
  namespace :admin do
    resources :rules
  end
  resource :wechat, only: [:show, :create]
  namespace :admin do
    resource :menu, only:[:edit, :create]
    resources :responses
    resources :rules do
      resources :responses
    end
    resources :response_rules
    get 'sign_in', to: 'sessions#new'
    post 'sign_in', to: 'sessions#create'
    delete 'sign_out', to: 'sessions#destroy'
    # get 'materials',to: 'materials#index'
    resources :materials
  end

  root 'sessions#new'
end
