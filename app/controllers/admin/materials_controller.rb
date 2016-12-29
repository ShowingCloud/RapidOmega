class Admin::MaterialsController < Admin::WechatApiController
  after_action :sync_material, only: [:index]
  def index
    @type = params[:type] || "news"
    offset = params[:offset] || "0"
    count = params[:count] || "10"
    @material = wechat.material_list(@type, offset, count)
    render :json => @material.to_json if @material
  end
  
  def show
    medium = Medium.find_by_media_id(params["id"]) 
    render :json => medium.to_json
  end
  
  private
  
  def sync_material
      @material["item"].each do |item|  
        medium = Medium.find_by_media_id(item["media_id"])
        if medium
          if medium.update_time <  item["update_time"]
            medium.update_attributes(item);
          end
        else
          item["media_type"] = @type
          Medium.create(item)
        end
      end
  end
end
