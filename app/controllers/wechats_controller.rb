class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    @rule = Rule.find_by_case("text")
    @responses = @rule.responses
    if @responses.length
      @responses.each do |r|
        wechat.custom_message_send Wechat::Message.to(request[:FromUserName]).send r.msgtype,(r.message)
      end
    end
    request.reply.success
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
