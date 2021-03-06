# -*- coding :utf-8 -*-
=begin rdoc
単語のモデルクラス
=end
class Word < ActiveRecord::Base
  include ActiveModel::Model

  # validates_xxx_ofを使うと 
  # undefined method `validate' for true:TrueClass
  # が発生するので、項目毎にvalidatesメソッドを呼び出し、条件を書くようにした
  validates :word,        presence: true,  :length => { :maximum => 16 }
  validates :description, presence: true,  :length => { :maximum => 32 }
  validates :example, :length => { :maximum => 64 }
  validates :translate, :length => { :maximum => 64 }
  validate :validates_example_and_translate 
  validate :validates_tweet

  def tweet
    return "[単語]: #{word}\n[意味]: #{description}\n[用例]: #{example}\n(#{translate})\n#下北弁"
  end

private
  def validates_example_and_translate
    if example.nil? or example.empty?
      errors.add(:example, "Example can't be blank.") unless translate.nil? or translate.empty?
    elsif translate.nil? or translate.empty?
      errors.add(:translate, "Translate can't be blank.") unless translate.nil? or example.empty?
    end
  end

  def validates_tweet
    errors.add('tweet', "Tweet is valud exceeded.") if tweet.size > 140
  end
end
