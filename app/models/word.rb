# -*- coding :utf-8 -*-
=begin rdoc
単語のモデルクラス
=end
class Word < ActiveRecord::Base
  include ActiveModel::Model

  attr_accessor :id

  # validates_xxx_ofを使うと 
  # undefined method `validate' for true:TrueClass
  # が発生するので、項目毎にvalidatesメソッドを呼び出し、条件を書くようにした
  validates :word,        presence: true,  :length => { :maximum => 16 }
  validates :description, presence: true,  :length => { :maximum => 32 }
  validates :example, :length => { :maximum => 64 }
  validates :translate, :length => { :maximum => 64 }
  validate :validates_example_and_translate

  # exampleとtranslateのいずれかがnil/emptyでないかどうか検証する
  def validates_example_and_translate
    logger.debug("example=#{example}, translate=#{translate}")
    if example.nil? or example.empty?
      errors.add(:example, "Example can't be blank.") unless translate.nil? or translate.empty?
    elsif translate.nil? or translate.empty?
      errors.add(:translate, "Translate can't be blank.") unless translate.nil? or example.empty?
    end
  end

end
