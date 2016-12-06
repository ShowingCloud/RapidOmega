Rails.application.routes.draw do
  resource :wechat, only: [:show, :create]
  namespace :admin do
    resource :menu, only:[:show, :create]
    get 'sign_in', to: 'sessions#new'
    post 'sign_in', to: 'sessions#create'
    get 'sign_out', to: 'sessions#destroy'
  end
end
