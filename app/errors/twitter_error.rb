# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
module Shimokitabenbot
  class TwitterError < Shimokitabenbot::BotInternalError
    def initialize(detail)
      super(detail)
    end
  end
end

