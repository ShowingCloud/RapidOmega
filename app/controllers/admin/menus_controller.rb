class Admin::MenusController < Admin::WechatApiController
  def show
    @menu = wechat.menu
  end

  def create
    menu = params[:menu]
    begin
      raise wechat.menu_create(JSON.parse(menu))
    rescue => error
      puts error.inspect
      render :json => {:msg=> error}, :status => 400
    else
      head :ok
    end
  end
end
