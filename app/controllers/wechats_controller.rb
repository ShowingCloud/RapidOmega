class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    wechat.custom_message_send Wechat::Message.to(request[:FromUserName]).image("mThew_r0IKT-4KXb9f6jZMePKX8lbskUUriyW1OjrzE")
    request.reply.text "感谢您关注豆姆Lab，您的留言我们已经收到，将尽快回复！您也可以添加客服微信号dome_lab，或者扫描下方二维码，方便沟通~"
  end

  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end

  on :event, with: 'subscribe' do |request|
    welcome = YAML.load(File.read(Rails.root.join('welcome.yml')))
    wechat.custom_message_send Wechat::Message.to(request[:FromUserName]).news(welcome['articles'])
    request.reply.text "欢迎来到豆姆Lab😘，预约免费机器人公开体验课，猛戳https://www.sojump.hk/jq/10897529.aspx"
  end

  on :fallback, respond: ''

end
