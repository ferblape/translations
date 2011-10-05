class Key < ActiveRecord::Base
  has_many :translations, :dependent => :destroy
  has_many :votes, :through => :translations 
  
  validates :key, :uniqueness => true, :presence => true
  
end
