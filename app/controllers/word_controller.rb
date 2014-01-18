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
      record = Word.new do |w|
        w.word = json['word']
        w.description = json['description']
        w.example = json['example']
        w.translate = json['translate']
        w.save!
      end
      logger.info('Insert record finished.')
      render :status => :created, :json => { "id" => record.id, "word" => record.word}.to_json
    rescue BotError => e
      render :status => e.status, :json => e.json
    rescue ActiveRecord::RecordInvalid => e
      if e.message.include?("can't be blank")
        render :status => :bad_request, :json => {"error" => {"code" => "11000003", "message" => "empty_val", "detail" => e.message }} if e.message.include?("can't be blank")
      else
        render :status => :bad_request, :json => {"error" => {"code" => "11000003", "message" => "val_exceeded", "detail" => e.message} } 
      end
    rescue => e
      logger.error(e)
      render :status => :internal_server_error, :json => {"error" => {"code" => '51000001', "message" => e.message, "detail" => ''}}.to_json
    end
    logger.info('Succeeded word regist.')
  end

  # 単語検索を行う
  def search
    
  end

end
