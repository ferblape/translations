class Key < ActiveRecord::Base
  has_many :translations, :dependent => :destroy
  validates :key, :uniqueness => true, :presence => true
end
