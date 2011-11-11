# coding: UTF-8
class ImportController < ApplicationController

  before_filter :login_required, :admin_required

  def new
  end

  def create
    if !params[:file]
      flash[:alert] = "Select a file"
    else
      import = File.open("tmp/imported_ymls/#{Time.now.to_i}_#{Rails.configuration.main_locale}.yml", 'wb')
      import.write(params[:file].read)
      import.close

      if Key.import(:file_path => import.path)
        flash[:notice] = "File imported"
      else
        flash[:alert] = "Can't upload file"
      end
    end
    render :new
  rescue
    flash[:alert] = $!.to_s
    render :new
  end

end