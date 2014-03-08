# -*- coding: utf-8 -*-
=begin
文章のモデル
=end
class Sentence < ActiveRecord::Base
  include ActiveModel::Model

  validates :sentence, presence: true, :length => { :maximum => 72 }
  validates :hashtag,  presence: true, :length => { :maximum => 72 }
  validate :validates_tweet

  def tweet
    return "#{sentence}\n#{hashtag}\n#下北弁"
  end

private
  def validates_tweet
    errors.add('tweet', "Tweet is valud exceeded.") if tweet.size > 140
  end

end
