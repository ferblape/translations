# coding: UTF-8
class KeysController < ApplicationController
  
  before_filter :login_required
  
  def index
      @keys = Key.paginate(:page => params[:page], :per_page => 20).order('id DESC')
  end

end