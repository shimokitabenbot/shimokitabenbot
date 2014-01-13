# -*- coding: utf-8 -*-
=begin rdoc
単語登録、更新、削除処理を行うコントローラ
=end
require 'bot_error'
class WordController < ApplicationController

  # 単語登録を行う
  def create
    logger.info('Start word regist.')
    begin
      body = request.body
      logger.debug("req_body: #{body}")
      # リクエストボディをチェックする
      json = validate_body_and_parse_json(body)
      logger.debug("json : #{json}")
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
    rescue EmptyBodyError => e
      logger.error(e)
      logger.debug("status : #{e.status}, json : #{e.json}")
      render :status => e.status, :json => e.json
    rescue NotJSONError => e
      logger.error(e)
      render :status => e.status, :json => e.json
    rescue => e
      logger.error(e)
      render :status => 500, :json => {"error" => {"code" => '51000001', "message" => e.message, "detail" => ''}}.to_json
    end
    logger.info('Succeeded word regist.')
  end

  # 単語検索を行う
  def search
    
  end

end
