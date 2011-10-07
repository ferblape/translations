# coding: UTF-8
class Vote < ActiveRecord::Base
  belongs_to :translation, :counter_cache => true
  belongs_to :user
  
  validates :translation_id, :presence => true
  validates :user_id, :presence => true
end
