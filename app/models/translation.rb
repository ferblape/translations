# coding: UTF-8
class Translation < ActiveRecord::Base
  belongs_to :key
  belongs_to :user
  has_many :votes, :dependent => :destroy
  # scope :order_by_votes, order("#{translations}.votes_count DESC")
  
  validates :language, :presence => true
  validates :translation, :presence => true
  validates :language, :inclusion => { :in => %w{en es}}
  
  after_create :create_or_update_vote
 
  def translation=(value)
    write_attribute(:translation, value.strip)
  end
  
  def save_if_not_exist
    if t = Translation.where(:translation => translation).first
      if vote = t.key.votes.where(:user_id => user_id).first
         vote.update_attribute(:translation, t)
      else
        Vote.create(:translation => t, :user => user)
      end
    else
      save
    end
  end

  private
  def create_or_update_vote
    if vote = key.votes.where(:user_id => user_id).first
       vote.update_attribute(:translation, self)
    else 
      votes.create(:user => user)
    end   
  end
  



end
