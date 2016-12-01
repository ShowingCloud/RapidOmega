Rails.application.routes.draw do
  resource :wechat, only: [:show, :create]
end
