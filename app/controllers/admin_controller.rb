class AdminController < ApplicationController
  before_action :require_admin

  def current_admin
      @current_admin ||= Admin.find session[:admin_id] if session[:admin_id]
      if @current_admin
        @current_admin
      else
        nil
      end
  end

  def require_admin
    unless current_admin
      redirect_to admin_sign_in_path
    end
  end

  def sign_in(admin)
    session[:admin_id] = admin.id
  end

end
