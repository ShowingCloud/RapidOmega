module Admin::SessionsHelper

  def require_admin
    unless current_admin
      redirect_to admin_sign_in_path
    end
  end

  def sign_in(admin)
    session[:admin_id] = admin.id
  end

  def current_admin
      @current_admin ||= Admin.find session[:admin_id] if session[:admin_id]
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
