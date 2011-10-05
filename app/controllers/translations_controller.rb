class TranslationsController < ApplicationController
  before_filter :load_key
  before_filter :load_reference_translation
  before_filter :load_user
  
  def index
    @translations = @key.translations.where("language = ?", @user.language)
  end

  def new
    @translation = @key.translations.new(:user => @user)
  end

  def create    
    @translation = @key.translations.new(params[:translation])
    @translation.user = @user
    @translation.language = @user.language
    if @translation.save
      flash[:notice] = "New translation created"
      redirect_to key_translations_path(@key)
    else
      render "new"
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
    
    def load_user
      @user = User.first
    end
    
end
