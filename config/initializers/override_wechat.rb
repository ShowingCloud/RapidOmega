Wechat::Message.class_eval do
  def mpnews(media_id)
    update(MsgType: 'mpnews', Mpnews: { MediaId: media_id })
  end
end

Wechat::Api.class_eval do
  def material(media_id)
    post 'material/get_material', JSON.generate(media_id: media_id), as: :file
  end
end
