# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
module Shimokitabenbot
  # 更新対象単語が複数存在する
  class SomeWordsForUpdateError < Shimokitabenbot::BotRequestError
    def initialize(detail)
      super(detail)
      @code = '11000003'
      @message = 'some_words_for_update'
    end
  end
end
