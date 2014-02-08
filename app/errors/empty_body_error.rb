# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
require 'bot_request_error'
module Shimokitabenbot
  # リクエストボディが空
  class EmptyBodyError < BotRequestError
    def initialize(detail = nil)
      super(detail)
      @code = '11000001'
      @message = 'empty_body'
    end
  end
end

