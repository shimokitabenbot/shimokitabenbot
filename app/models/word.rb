# -*- coding :utf-8 -*-
=begin rdoc
単語のモデルクラス
=end
class Word < ActiveRecord::Base

  # エラーメッセージ定数
  MSG_TOO_LONG_WORD = 'Word is too long.'
  MSG_TOO_LONG_DESC = 'Description is too long.'
  MSG_TOO_LONG_EXAM = 'Example is too long.'
  MSG_TOO_LONG_TRNS = 'Translate is too long.'

  attribute_accessor :id, :word, :description, :example, :translate

  # 単語が一意かどうかチェックする
  validates_uniqueness_of :word

  # 値が空じゃないかどうかチェックする
  validates_presence_of :word, :description

  # 文字列の長さをチェックする
  validates_length_of :word, maximum: 16, too_long: MSG_TOO_LONG_WORD
  validates_length_of :description, maximum: 32, too_long: MSG_TOO_LONG_DESC
  validates_length_of :example, maximum: 64, too_long: MSG_TOO_LONG_EXAM
  validates_length_of :translate, maximum: 64, too_long: MSG_TOO_LONG_TRNS
  
end
