class Key < ActiveRecord::Base
  has_many :translations, :dependent => :destroy
  validates :key, :uniquenes => true, :presence => true
end
