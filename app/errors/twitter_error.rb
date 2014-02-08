# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
require 'bot_internal_error'
module Shimokitabenbot
  class TwitterError < BotInternalError
    def initialize(detail)
      super(detail)
    end
  end
end

