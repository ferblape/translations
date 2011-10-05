class Translation < ActiveRecord::Base
  belongs_to :key
  belongs_to :user
  has_many :votes, :dependent => :destroy
#  scope :order_by_votes, order("#{translations}.votes_count DESC")
  
  validates :language, :presence => true
  validates :translation, :presence => true
  validates :language, :inclusion => { :in => %w{en es}}
  
  before_create :check_translation_exists
  after_create :create_or_update_vote
 
 
  private

  def check_translation_exists 
    if t = Translation.where(:translation => translation).first
      if vote = t.votes.where(:user_id => user_id).first
         vote.update_attributes(:translation_id => t.id)
      else
        Vote.create(:translation_id => t.id, :user_id => user_id)
      end
      return false
    end
  end


  def create_or_update_vote
    if vote = key.votes.where(:user_id => user_id).first
       vote.update_attribute(:translation_id, id)
    else 
      votes.create(:user_id => user_id)
    end   
  end
  



end
