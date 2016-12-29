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

  def require_super_admin
    flash[:notice] = "需要超级管理员权限" && redirect_back(fallback_location: root_path) unless current_admin.superadmin?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def super_admins_only(&block)
    block.call if current_admin.try(:superadmin?)
  end
end
