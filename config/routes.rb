Rails.application.routes.draw do
  namespace :admin do
    get 'materials/index'
  end

  resource :wechat, only: [:show, :create]
  namespace :admin do
    resource :menu, only:[:show, :create]
    get 'sign_in', to: 'sessions#new'
    post 'sign_in', to: 'sessions#create'
    delete 'sign_out', to: 'sessions#destroy'
    get 'materials',to: 'materials#index'
  end
end
