# coding: UTF-8
class TranslationsController < ApplicationController
  before_filter :load_key
  before_filter :load_reference_translation
  before_filter :login_required
  def index
     @translation = @key.translations.new(:user => current_user)
    @translations = @key.translations.where("language = ?", current_user.language)
  end

  def new
    @translation = @key.translations.new(:user => current_user)
  end

  def create    
    @translation = @key.translations.new(params[:translation])
    @translation.user = current_user
    @translation.language = current_user.language
    if @translation.save_if_not_exist
      flash[:notice] = "New translation created"
      redirect_to key_translations_path(@key)
    else
      flash[:alert] = "Error: #{@translation.errors.full_messages.to_sentence}"
      redirect_to key_translations_path(@key)
    end
  end

  def edit   
  end

  def update
  end
  
  protected
    def load_key
      unless @key = Key.find(params[:key_id])
        render_404 and return false
      end
    end
    
    def load_reference_translation
      unless @reference_translation = @key.translations.where("language = 'en'").first
        render_404 and return false
      end
    end
    
end