class Admin::MenusController < Admin::WechatApiController
  def edit
    @menu = wechat.menu
  end

  def create
    menu = params[:menu]
    if wechat.menu_create(JSON.parse(menu))
      head :ok
    else
      head :bad_request
    end
  end
end
