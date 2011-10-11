# coding: UTF-8
class KeysController < ApplicationController
  
  before_filter :login_required
  
  def index
    if params[:search]
        @keys = Key.paginate(:page => params[:page], :per_page => 20).order('keys.id DESC').where("translation LIKE '%#{params[:search]}%'").joins(:translations).select("distinct(keys.id)")
    else
        @keys = Key.paginate(:page => params[:page], :per_page => 20).order('id DESC')
    end
  
  
  end
  
  
end