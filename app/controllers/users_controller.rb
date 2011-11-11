# coding: UTF-8

class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "New user added"
      session[:user_id] = @user.id
      redirect_to keys_path
    else
      flash[:alert] = "Please check the fields"
      render :new
    end
  end

end
