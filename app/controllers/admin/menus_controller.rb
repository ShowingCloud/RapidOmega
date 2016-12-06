class Admin::MenusController < AdminController
  wechat_api
  def show
    @menu = wechat.menu
  end

  def create
    menu = params[:menu]
    wechat.menu_create(JSON.parse(menu))
  end
end
