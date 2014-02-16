# -*- coding: utf-8 -*-
=begin
文章のモデル
=end
class Sentence < ActiveRecord::Base
  include ActiveModel::Model  

  validates :sentence, presence: true, :length => { :maximum => 76 }
  validates :hashtag,  presence: true, :length => { :maximum => 76 }

  def tweet
    return "#{sentence}\n#{hashtag}\n#下北弁"
  end

end
