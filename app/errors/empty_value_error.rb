# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
require 'bot_request_error'
module Shimokitabenbot
  # JSONのキーに対応する値が空
  class EmptyValueError < BotRequestError
    def initialize(detail)
      super(detail)
      @code = '11000003'
      @message = 'empty_value'
    end
  end
end

