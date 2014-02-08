# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
module Shimokitabenbot
  # リクエストボディが空
  class EmptyBodyError < Shimokitabenbot::BotRequestError
    def initialize(detail)
      super(detail)
      @code = '11000001'
      @message = 'empty_body'
    end
  end
end

