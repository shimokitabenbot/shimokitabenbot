# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
module Shimokitabenbot
  # 文字数オーバー
  class ValueExceededError < Shimokitabenbot::BotRequestError
    def initialize(detail)
      super(detail)
      @code = '11000003'
      @message = 'value_exceeded'
    end
  end
end
