# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
require 'bot_error'
module Shimokitabenbot
  # 内部エラー
  class BotInternalError < BotError
    def initialize(detail)
      @status = 500
      @code = '53000001'
      @message = 'internal_error'
      @detail = detail
    end
  end
end

