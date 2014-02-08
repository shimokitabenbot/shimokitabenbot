# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
module Shimokitabenbot
  class BotRequestError < BotError
    def initialize(detail = nil)
      @status = 400
      @detail = detail
    end
  end
end

