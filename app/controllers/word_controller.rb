# -*- coding: utf-8 -*-
=begin rdoc
単語登録、更新、削除処理を行うコントローラ
=end
class WordController < ApplicationController

  # 単語登録を行う
  def create
    logger.info('Start word regist.')
  	begin
  	  # リクエストヘッダをチェックする
#  	  validate_header(request.headers)
  	  # リクエストボディを取得する
      body = request.body
      # リクエストボディをチェックする
      json = validate_body_and_parse_json(body)
      logger.debug('request body verifying : OK') unless json.nil? or json.empty?

      # Wordsテーブルに登録する
      id = 0
      logger.debug("record: #{json['word']}, description: #{json['description']}, example: #{json['example']}, translate: #{json['translate']}")
      Word.new do |w|
        w.word = json['word']
        w.description = json['description']
        w.example = json['example']
        w.translate = json['translate']
        w.save!
        id = w.id
      end
      logger.info('Insert record finished.')
      render :status => 200, :json => { "id" => id, "word" => word}.to_json
    rescue NotJSONError => e
      render :status => e.status, :json => e.json
    rescue => e
      render :status => 500 :json => {"error" => {"code" => '51000001', "message" => e.message, "detail" => ''}}.to_json
    end
    logger.info('Succeeded word regist.')
  end

  # 単語検索を行う
  def search
    
  end

end
