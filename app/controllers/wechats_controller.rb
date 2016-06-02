class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    request.reply.text "echo: #{content}" # Just echo
  end

  on :event, with: 'subscribe' do |request|
    request.reply.text "哈喽！#{request[:FromUserName]}" #Say hello
  end

  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end

  on :scan, with: 'qrscene_xxxxxx' do |request, ticket|
    request.reply.text "Unsubscribe user #{request[:FromUserName]} Ticket #{ticket}"
  end

  # When subscribe user scan scene_id in public account
  on :scan, with: 'scene_id' do |request, ticket|
    request.reply.text "Subscribe user #{request[:FromUserName]} Ticket #{ticket}"
  end
end
