# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
module Shimokitabenbot
  class BotRequestError < Shimokitabenbot::BotError
    def initialize(detail = nil)
      @status = 400
      @detail = detail
    end
  end
end

