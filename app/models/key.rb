# coding: UTF-8
class Key < ActiveRecord::Base
  has_many :translations, :dependent => :destroy
  has_many :votes, :through => :translations

  validates :key, :uniqueness => true, :presence => true

  def main_locale
    t = translations.where(:language => Rails.configuration.main_locale).first
    t.translation
  end

  def most_voted(language)
    if t = translations.where(:language => language).order("votes_count DESC").first
      t.translation
    end
  end

  def export
    # send_file (generated)
    #

  end


end
