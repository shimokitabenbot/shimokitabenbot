# -*- coding: utf-8 -*-
=begin rdoc
エラークラス
=end
# エラー基底クラス。
class BotError < StandardError 
  attr_accessor :code, :message, :detail, :status

  def initialize(val = nil)
    @status = 400
  end

  # エラー情報JSONオブジェクトを作成する。
  def json
    error = {}
    error['code'] = @code
    error['message'] = @message
    error['detail'] = @detail
    {"error" => error}.to_json
  end
end

# リクエストボディが空
class EmptyBodyError < BotError
  def initialize
    super
    @code = '11000001'
    @message = 'empty_body'
    @detail = nil
  end
end

# リクエストボディがJSONではないエラー
class NotJSONError < BotError
  def initialize(json)
    super
    @code = '11000001'
    @message = 'not_json'
    @detail = json
  end
end

# JSONのキーに対応する値が空
class EmptyValueError < BotError
  def initialize(key)
    super
    @code = '11000003'
    @message = 'empty_value'
    @detail = key
  end
end

class ValueExceededError < BotError
  def initialize(key)
    super
    @code = '11000003'
    @message = 'value_exceeded'
    @detail = key
  end
end
