# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
module Shimokitabenbot
  # 内部エラー
  class BotInternalError < Shimokitabenbot::BotError
    def initialize(detail)
      @status = 500
      @code = '53000001'
      @message = 'internal_error'
      @detail = detail
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

# 更新対象単語が複数存在する
class SomeWordsForUpdateError < BotError
  def initialize(detail)
    super
    @code = '11000003'
    @message = 'some_words_for_update'
    @detail = detail
  end
end

