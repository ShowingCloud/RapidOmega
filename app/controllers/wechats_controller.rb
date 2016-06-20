class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    request.reply.text "echo: #{content}" # Just echo
  end

  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end
  
  on :event, with: 'subscribe' do |request|
    welcome = YAML.load(File.read(Rails.root.join('welcome.yml')))
    wechat.custom_message_send Wechat::Message.to(request[:FromUserName]).news(welcome['articles'])
  end
  
  on :click, with: 'about' do |request, key|
    welcome = YAML.load(File.read(Rails.root.join('welcome.yml')))
    wechat.custom_message_send Wechat::Message.to(request[:FromUserName]).news(welcome['articles'])
  end


  # Any not match above will fail to below
  on :fallback, respond: 'fallback message'

end
