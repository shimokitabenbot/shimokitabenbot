# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
module Shimokitabenbot
  class BotError < StandardError 
    attr_accessor :code, :message, :detail, :status

    # エラー情報JSONオブジェクトを作成する。
    def to_json
      error = {}
      error['code'] = @code
      error['message'] = @message
      error['detail'] = @detail
      {"error" => error}.to_json
    end
  end
end

