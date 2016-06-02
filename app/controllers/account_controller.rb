class AccountController < ApplicationController

  wechat_api
  def index
    @ticket=wechat.qrcode_create_scene [123, 6000]
    @qrcode_url = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket="+@ticket["ticket"]
  end

end
