Rails.application.routes.draw do
  get 'account/index'
  get 'account/get_temp_qr',to:"account#get_temp_qr"

  get 'secret/index'

  devise_for :users, controllers: {
               omniauth_callbacks: 'omniauth_callbacks'
             }
  root 'welcome#index'
  resource :wechat, only: [:show, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
