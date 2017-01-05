class Admin::TestController < AdminController

  def custom_msg
    Wechat.api.custom_message_send Wechat::Message.to(params[:touser]).send params[:msgtype],params[:content]
  end
end
