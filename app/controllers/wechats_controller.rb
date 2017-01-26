class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    auto_response('text',request)
  end

  on :image do |request|
    auto_response('image',request)
  end

  on :voice do |request|
    auto_response('voice',request)
  end

  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end

  on :event, with: 'subscribe' do |request|
    auto_response('subscribe',request)
  end

  on :fallback, respond: ''

  def auto_response(event,request,content = nil)
    if event == 'text'
      @rule
      Rule.where(:event => "text").where.not(:keyword => nil).includes(:responses).where(:responses_count => 1).each do |rule|
        if rule.fullmatch
          @rule = rule && break  if rule.keyword == content
        else
          @rule = rule && break if content.include? rule.keyword
        end
      end
      @rule = Rule.find_by(:event => 'text',:keyword => nil) unless @rule.present?
    else
      @rule = Rule.find_by_event(event)
    end
    request.reply.success && return unless @rule.present?
    @responses = @rule.responses
    if @responses.length
      @responses.each do |r|
        if r.msgtype == "mpnews"
          wechat.custom_message_send :touser=>request[:FromUserName], :msgtype=>r.msgtype, :mpnews=>{:media_id=>r.message}
        else
          wechat.custom_message_send Wechat::Message.to(request[:FromUserName]).send r.msgtype,(r.message)
        end
      end
    end
    request.reply.success
  end

end
