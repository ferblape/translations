# coding: UTF-8
class Key < ActiveRecord::Base
  has_many :translations, :dependent => :destroy
  has_many :votes, :through => :translations 
  
  validates :key, :uniqueness => true, :presence => true
  
  def english 
    t = translations.where(:language => "en").first
    t.translation
  end
  
  def most_voted(language)
    if t = translations.where(:language => language).order("votes_count DESC").first
      t.translation
    end
  end
end
