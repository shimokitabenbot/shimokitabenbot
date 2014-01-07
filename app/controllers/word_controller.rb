# -*- coding: utf-8 -*-
=begin rdoc
単語登録、更新、削除処理を行うコントローラ
=end
class WordController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include HTTPRequestValidator

  # 単語登録を行う
  def create
  	begin
  	  # リクエストヘッダをチェックする
  	  validate_header(request.headers)
  	  # リクエストボディを取得する
      body = request.body
      # リクエストボディをチェックする
      json = validate_body_and_parse_json(body)

      # Wordsテーブルに登録する
      id = 0
      Word.new do |w|
        w.word = json['word']
        w.description = json['description']
        w.example = json['example']
        w.translate = json['translate']
        w.save!
        id = w.id
      end
      render :status => 200, :json => { "id" => id, "word" => word}.to_json
    rescue InvalidContentType => e
      render :status => e.status, :json => e.json
    rescue NotJSON => e
      render :status => e.status, :json => e.json
    rescue 

    end

  end

  private

end
