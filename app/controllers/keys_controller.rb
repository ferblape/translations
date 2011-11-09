# coding: UTF-8

class KeysController < ApplicationController

  before_filter :login_required
  before_filter :admin_required, :only => :export

  def index
    if params[:search]
      @keys = Key.where("translation LIKE '%#{params[:search]}%'").joins(:translations).select("distinct(keys.id)")
    else
      @keys = Key.order_by_non_translated_desc(current_user.language).paginate(:page => params[:page], :per_page => 20)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def export
    export = File.open("tmp/#{current_user.language}.yml",'w+')
    export.write(Key.export(current_user.language))
    export.close
    send_file "tmp/#{current_user.language}.yml", :type => 'text/yaml'
  end

end