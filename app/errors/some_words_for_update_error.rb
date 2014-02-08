# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
require 'bot_request_error'
module Shimokitabenbot
  # 更新対象単語が複数存在する
  class SomeWordsForUpdateError < BotRequestError
    def initialize(detail)
      super(detail)
      @code = '11000003'
      @message = 'some_words_for_update'
    end
  end
end
