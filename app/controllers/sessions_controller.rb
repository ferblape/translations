# coding: UTF-8
class SessionsController < ApplicationController
  
  def new
    if session[:user_id]
      redirect_to keys_path
    end
  end
  
  def create
    if user = User.authenticate(params[:identifier], params[:password])
      session[:user_id] = user.id
      redirect_to keys_path
    else
      flash.now.alert = "No se ha podido iniciar sesión"
      render "new"
    end
  end
  
  def destroy
    reset_session
    redirect_to login_path
  end

end