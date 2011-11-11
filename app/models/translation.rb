# coding: UTF-8

class Translation < ActiveRecord::Base

  belongs_to :key
  belongs_to :user
  has_many :votes, :dependent => :destroy

  attr_protected :user_id

  validates :language, :presence => true
  validates :translation, :presence => true
  validates :language, :inclusion => { :in => %w{en es}}

  after_create :create_or_update_vote
  before_validation :user_language

  def translation=(value)
    write_attribute(:translation, value.strip)
  end

  def language=(value)
    value = value.to_s
    super
  end

  def save_if_not_exist
    if t = Translation.where(:translation => translation, :language => self.language).first
      if vote = t.key.votes.where(:user_id => user_id).first
         vote.update_attribute(:translation, t)
      else
        Vote.create(:translation => t, :user => user)
      end
    else
      save
    end
  end

  def next
    Key.where("id < #{self.key_id}").order('id DESC').first
  end

  def previous
    Key.where("id > #{self.key_id}").order('id ASC').first
  end

  def key_string
    self.key.key
  end

  private

  def create_or_update_vote
    if vote = key.votes.where(:user_id => user_id).first
       vote.update_attribute(:translation, self)
    else
      votes.create(:user => user)
    end
  end

  def user_language
    self.language = user ? user.language : Rails.configuration.main_locale
  end

end
