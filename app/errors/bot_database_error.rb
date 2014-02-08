# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
require 'bot_internal_error'
module Shimokitabenbot
  # データベースエラー
  class BotDatabaseError < BotInternalError
    def initialize(detail)
      super(detail)
      @code = '51000001'
      @message = 'database_error'
    end
  end
end

