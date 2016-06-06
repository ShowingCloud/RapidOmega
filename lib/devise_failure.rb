class DeviseFailure < Devise::FailureApp
  def redirect_url
    if request.user_agent.match(/micromessenger/i)
      user_wechat_omniauth_authorize_path
    else
      new_user_session_path
    end
  end
end
