class AccountController < ApplicationController
  before_action :authenticate_user!
  wechat_api
  def index
    @scen_id = SecureRandom.random_number(100000)
    @ticket = wechat.qrcode_create_scene @scen_id, 6000
    Rails.cache.write(@scen_id.to_s,current_user.id,:expires_in =>6000.seconds)
    @qrcode_url = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket="+@ticket["ticket"]
  end

  def unbind_wechat
    @user=User.find(current_user.id)
    @user.update(provider:nil,uid:nil,nickname:nil)
    redirect_to :back
  end

end
