# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
module Shimokitabenbot
  # データベースエラー
  class BotDatabaseError < Shimokitabenbot::BotInternalError
    def initialize(detail)
      super(detail)
      @code = '51000001'
      @message = 'database_error'
    end
  end
end

