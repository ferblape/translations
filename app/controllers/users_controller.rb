class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user]) 
    if @user.save
      flash[:notice] = "Usuario creado"
      session[:user_id] = @user.id
      redirect_to keys_path
    else
      flash[:alert] = "Error al crear el usuario"
      render :new
    end
  end
  
  
end
