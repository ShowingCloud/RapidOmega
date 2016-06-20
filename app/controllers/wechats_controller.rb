class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    request.reply.text "echo: #{content}" # Just echo
  end

  #unsubscribe user scan and subscribe
  # on :event, with: "subscribe" do |request, content|
  #   if request[:EventKey].present? && request[:EventKey].start_with?("qrscene")
  #     @key = request[:EventKey].split("_").last
  #     if @user_id=Rails.cache.read(@key)
  #         @user=User.find(@user_id)
  #         unless @user.uid
  #             @info=wechat.user request[:FromUserName]
  #             @user.update(provider:"wechat",uid:request[:FromUserName],nickname:@info["nickname"])
  #             template={"template_id"=>"veJ3fZdBX5QqhjVLlvI-vXkRyW08slisYusPA8J2pm0", "url"=>"https://weixin-bikeman18.c9users.io/account/index", "topcolor"=>"#FF0000", "data"=>{"email"=>{"value"=>@user.email, "color"=>"#0A0A0A"}}}
  #             wechat.template_message_send Wechat::Message.to(request[:FromUserName]).template(template)
  #         end
  #     end
  #   else
  #     request.reply.text "哈喽！Robodou欢迎你～"
  #   end
  # end

  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end
  
  on :event, with: 'subscribe' do |request|
    welcome = YAML.load(File.read(Rails.root.join('welcome.yml')))
    wechat.custom_message_send Wechat::Message.to(request[:FromUserName]).news(welcome['articles'])
  end

#   on :event, with: "scan" do |request, content|
#   if request[:EventKey].present?
#     @key =  request[:EventKey]
#     if @user_id=Rails.cache.read(@key)
#       @user=User.find(@user_id)
#       @user.update(provider:"wechat",uid:request[:FromUserName]) unless @user.uid
#     end
    
#   end
#   request.reply.text @user.email
# end

  # When user click the menu button
  on :click, with: 'baoming' do |request, key|
    request.reply.text "User: #{request[:FromUserName]} click #{key}"
  end

  # When user view URL in the menu button
  on :view, with: "https://weixin-bikeman18.c9users.io/secret/index.html" do |request, view|
    request.reply.text "#{request[:FromUserName]} view #{view}"
  end

  # When user sent the imsage
  on :image do |request|
    request.reply.image(request[:MediaId]) # Echo the sent image to user
  end

  # When user sent the voice
  on :voice do |request|
    request.reply.voice(request[:MediaId]) # Echo the sent voice to user
  end

  # When user sent the video
  on :video do |request|
    nickname = wechat.user(request[:FromUserName])['nickname'] # Call wechat api to get sender nickname
    request.reply.video(request[:MediaId], title: 'Echo', description: "Got #{nickname} sent video") # Echo the sent video to user
  end

  # When user sent location
  on :location do |request|
    request.reply.text("Latitude: #{request[:Latitude]} Longitude: #{request[:Longitude]} Precision: #{request[:Precision]}")
  end

  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end

  # When user enter the app / agent app
  on :event, with: 'enter_agent' do |request|
    request.reply.text "#{request[:FromUserName]} enter agent app now"
  end

  # When batch job create/update user (incremental) finished.
  on :batch_job, with: 'sync_user' do |request, batch_job|
    request.reply.text "sync_user job #{batch_job[:JobId]} finished, return code #{batch_job[:ErrCode]}, return message #{batch_job[:ErrMsg]}"
  end

  # When batch job replace user (full sync) finished.
  on :batch_job, with: 'replace_user' do |request, batch_job|
    request.reply.text "replace_user job #{batch_job[:JobId]} finished, return code #{batch_job[:ErrCode]}, return message #{batch_job[:ErrMsg]}"
  end

  # When batch job invent user finished.
  on :batch_job, with: 'invite_user' do |request, batch_job|
    request.reply.text "invite_user job #{batch_job[:JobId]} finished, return code #{batch_job[:ErrCode]}, return message #{batch_job[:ErrMsg]}"
  end

  # When batch job replace department (full sync) finished.
  on :batch_job, with: 'replace_party' do |request, batch_job|
    request.reply.text "replace_party job #{batch_job[:JobId]} finished, return code #{batch_job[:ErrCode]}, return message #{batch_job[:ErrMsg]}"
  end

  # Any not match above will fail to below
  on :fallback, respond: 'fallback message'

  private
  def bind_wechat

  end

end
