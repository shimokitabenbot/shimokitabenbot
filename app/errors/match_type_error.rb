# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
module Shimokitabenbot

  class MatchTypeError < Shomokitabenbot::BotRequestError
    def initialize(detail)
      super(detail)
      @code = '11000003'
      @message = 'match_type_error'
    end
  end
end

# 単語更新でID,単語両方ない場合
class NoIdAndWordError < BotError
  def initialize(detail = nil)
    super
    @code = '11000003'
    @message = 'no_id_and_word'
  end
end
