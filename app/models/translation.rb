class Translation < ActiveRecord::Base
  belongs_to :key
  belongs_to :user
  has_many :votes, :dependent => :destroy
  
  validates :language, :presence => true
  validates :translation, :presence => true
  validates :key_id, :uniqueness => {:scope => :user_id}
  validates :language, :inclusion => { :in => %w{en es}}

end
