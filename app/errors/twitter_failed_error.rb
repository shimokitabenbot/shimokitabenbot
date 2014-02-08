# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
require 'twitter_error'
module Shimokitabenbot
  # Twitter失敗
  class TwitterFailedError < TwitterError
    def initialize(detail)
      super(detail)
      @code = '52000002'
      @message = 'twitter_failed'
    end
  end
end

