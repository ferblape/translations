class User < ActiveRecord::Base
  has_many :votes, :dependent => :destroy
  has_many :translations, :dependent => :destroy
  
  validates :email, :uniqueness => true, :presence => true
  validates :username, :uniqueness => true, :presence => true
  validates :password, {:presence => {:on => :create}, :length => {:minimum => 4, :on => :create}}
  validates :language, :inclusion => { :in => %w{en es}}, :presence => true
  
  has_secure_password
end
