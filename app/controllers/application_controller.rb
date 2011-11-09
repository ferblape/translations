# coding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  def render_404
    render :file => "public/404.html", :status => 404, :layout => false
  end
  
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end    
  end
  
  def login_required
    if !session[:user_id]
      redirect_to login_path and return false
    end
  end
  
  def admin_required
    return render_404 unless current_user.is_admin?   
  end
  
end
