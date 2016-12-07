class Admin::MaterialsController < Admin::WechatApiController
  def index
    type = params[:type] || "news"
    offset = params[:offset] || "0"
    count = params[:count] || "10"
    material = wechat.material_list(type, offset, count)
    render :json => material.to_json if material
  end

end
