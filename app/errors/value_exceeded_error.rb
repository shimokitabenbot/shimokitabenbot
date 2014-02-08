# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
require 'bot_request_error'
module Shimokitabenbot
  # 文字数オーバー
  class ValueExceededError < BotRequestError
    def initialize(detail)
      super(detail)
      @code = '11000003'
      @message = 'value_exceeded'
    end
  end
end
