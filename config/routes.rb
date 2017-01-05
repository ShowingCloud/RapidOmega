Rails.application.routes.draw do
  resource :wechat, only: [:show, :create]
  namespace :admin do
    resource :menu, only:[:show, :create]
    resources :responses
    resources :rules do
      resources :responses
    end
    resources :response_rules
    get 'sign_in', to: 'sessions#new'
    post 'sign_in', to: 'sessions#create'
    delete 'sign_out', to: 'sessions#destroy'
    resources :materials, only:[:index, :show]
    root to: "dashboards#welcome"
  end

  root 'sessions#new'
end
