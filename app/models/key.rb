# coding: UTF-8
class Key < ActiveRecord::Base
  has_many :translations, :dependent => :destroy
  has_many :votes, :through => :translations 
  
  validates :key, :uniqueness => true, :presence => true
  
  def english 
    t = translations.where(:language => "en").first
    t.translation
  end
  
end
