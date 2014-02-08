# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
require 'bot_request_error'
module Shimokitabenbot
  # 単語更新でID,単語両方ない場合
  class NoIdAndWordError < BotRequestError
    def initialize(detail)
      super(detail)
      @code = '11000003'
      @message = 'no_id_and_word'
    end
  end
end
