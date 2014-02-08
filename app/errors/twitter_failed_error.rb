# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
module Shimokitabenbot
  # Twitter失敗
  class TwitterFailedError < Shimokitabenbot::TwitterError
    def initialize(detail)
      super(detail)
      @code = '52000002'
      @message = 'twitter_failed'
    end
  end
end

