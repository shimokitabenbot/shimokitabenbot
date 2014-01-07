# -*- coding: utf-8 -*-
=begin rdoc
HTTPリクエストデータの検証を行うモジュール
=end
module HTTPRequestValidator

  include Constants

  # リクエストヘッダを検証し、正常でなければ、エラーを返す。
  # 検証項目は以下の通り。
  # * Content-Typeのnilチェック
  # * Content-Typeがapplication/jsonかどうかチェック
  def validate_header(header)
    content_type = header['Content-Type']
    raise InvalidContentType if content_type.nil? or content_type.empty? or content_type != CONTENT_TYPE
  end

  # リクエストボディを検証し、正常であればJSONにパースしたものを返す。
  # 正常でなければ、エラーを返す
  # 検証項目は以下の通り。
  # * リクエストボディのnilチェック
  # * リクエストボディのJSONチェック
  def validate_body_and_parse_json(body)
    # nilまたは空の場合は終了。
    raise EmptyBody if body.nil? or body.empty?
    json = nil
    begin
      json = JSON.parse(body)
    rescue JSONError => e
      raise NotJSON
    end
    return json
  end

end