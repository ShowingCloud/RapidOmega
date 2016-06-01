Rails.application.routes.draw do
  get 'secret/index'

  devise_for :users, controllers: {
               omniauth_callbacks: 'omniauth_callbacks'
             }
  root 'welcome#index'
  resource :wechat, only: [:show, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
