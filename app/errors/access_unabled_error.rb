# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
module Shimokitabenbot
  # Twitterアクセスエラー
  class AccessUnabledError < Shimokitabenbot::TwitterError
    def initialize(detail)
      super(detail)
      @code = '52000001'
      @message = 'access_unabled'
    end
  end
end

