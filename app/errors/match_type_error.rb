# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
require 'bot_request_error'
module Shimokitabenbot

  class MatchTypeError < BotRequestError
    def initialize(detail)
      super(detail)
      @code = '11000003'
      @message = 'match_type_error'
    end
  end
end

