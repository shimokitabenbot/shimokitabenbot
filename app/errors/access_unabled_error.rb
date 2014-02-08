# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
module Shimokitabenbot
  # Twitterアクセスエラー
  class AccessUnabledError < TwitterError
    def initialize(detail)
      super(detail)
      @code = '52000001'
      @message = 'access_unabled'
    end
  end
end

