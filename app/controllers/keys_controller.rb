# coding: UTF-8
class KeysController < ApplicationController
  
  before_filter :login_required
  
  def index
      @translations = Translation.where(:language => current_user.language).order('votes_count ASC').select("DISTINCT(key_id)").paginate(:page => params[:page], :per_page => 20)
    
  end

end