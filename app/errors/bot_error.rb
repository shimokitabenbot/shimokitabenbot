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

# JSONのキーに対応する値が空
class EmptyValueError < BotError
  def initialize(key)
    super
    @code = '11000003'
    @message = 'empty_value'
    @detail = key
  end
end

# 文字数オーバー
class ValueExceededError < BotError
  def initialize(key)
    super
    @code = '11000003'
    @message = 'value_exceeded'
    @detail = key
  end
end

class MatchTypeError < BotError
  def initialize(key)
    super
    @code = '11000003'
    @message = 'match_type_error'
    @detail = key
  end
end

# 内部エラー
class BotInternalError < BotError
  def initialize(detail)
    @status = 500
    @code = '53000001'
    @message = 'internal_error'
    @detail = detail
  end
end

# データベースエラー
class BotDatabaseError < BotError
  def initialize(detail)
    @status = 500
    @code = '51000001'
    @message = 'database_error'
    @detail = detail
  end
end

# Twitterアクセスエラー
class AccessUnabledError < BotError
  def initialize(detail)
    @status = 500
    @code = '52000001'
    @message = 'access_unabled'
    @detail = detail
  end
end

# Twitter失敗
class TwitterFailedError < BotError
  def initialize(detail)
    @status = 500
    @code = '52000002'
    @message = 'twitter_failed'
    @detail = detail
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
