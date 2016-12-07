class Admin::SessionsController < AdminController
  skip_before_action :require_admin
  layout 'session'

   def new
   end

   def create
     admin = Admin.find_by(email: params[:session][:email].downcase)
     if admin && admin.authenticate(params[:session][:password])
       sign_in admin
       redirect_to admin_menu_path
     else
       flash.now[:danger] = '错误的邮箱密码组合'
       render 'new'
     end
   end

   def destroy
     log_out
     redirect_to admin_sign_in_path
   end
end
