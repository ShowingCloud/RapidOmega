Rails.application.routes.draw do
  resource :wechat, only: [:show, :create]
  namespace :admin do
    resource :menu, only:[:show, :create]
    resource :response
    resource :rule
    resource :response_rule
    get 'sign_in', to: 'sessions#new'
    post 'sign_in', to: 'sessions#create'
    delete 'sign_out', to: 'sessions#destroy'
    get 'materials',to: 'materials#index'
  end
end
