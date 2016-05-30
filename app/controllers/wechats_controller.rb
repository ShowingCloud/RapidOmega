class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    request.reply.text "echo: #{content}" # Just echo
  end

  on :event, with: 'subscribe' do |request|
    request.reply.text "哈喽！" #Say hello
  end

  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end
end
