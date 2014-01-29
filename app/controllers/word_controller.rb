# -*- coding: utf-8 -*-
=begin rdoc
単語登録、更新、削除処理を行うコントローラ
=end
require 'bot_error'
class WordController < ApplicationController

  # 単語登録を行う
  def create
    logger.info('Start word regist.')
    raise EmptyBodyError if params.nil? or !params.has_key?(:description)
    # Wordsテーブルに登録する
    id = 0
    logger.debug("#{params[:word]}, #{params[:decription]}, #{params[:example]}, #{params[:translate]}")
    record = nil
    begin
      logger.info('Insert record started')
      record = Word.new do |w|
        w.word = params[:word]
        w.description = params[:description]
        w.example = params[:example]
        w.translate = params[:translate]
        w.save!
      end
      logger.info('Insert record finished.')
      render :status => :created, :json => { "id" => record.id, "word" => record.word}.to_json
      logger.info('Succeeded word regist.')
    rescue ActiveRecord::RecordInvalid => e
      if e.message.include?("can't be blank")
        logger.error(e)
        raise EmptyValueError, e.message 
      elsif e.message.include?("too long")
        logger.error(e)
        raise ValueExceededError, e.message
      else
        logger.error(e)
        raise BotInternalError, e.message
      end
    rescue => e
      logger.error(e)
      raise BotInternalError, e.message
    end
  end

  # 単語検索を行う
  def search
    logger.info("Start word search.")
    validate_match_type(params[:match_type]) if params[:match_type]

    words = nil
    if params[:word]
      # 単語が指定されている場合、単語検索
      if params[:match_type].nil? or params[:match_type] == 'complete'
        logger.info("完全一致")
        words = Word.where(:word => params[:word])
      elsif params[:match_type] == 'part'
        logger.info("部分一致")
        words = Word.where(["word like ?", "%#{params[:word]}%"])
      end
    else
      logger.info("全件検索")
      # 単語が指定されていない場合、全件検索
      words = Word.all 
    end
    if words.nil? or words.empty?
      logger.info("Not found")
      # 何も返さない場合は、JSONを空にしないとエラー
      render :status => :not_found, :json => {}.to_json
    else
      logger.info("検索件数: #{words.size}")
      render :status => :ok, :json => words.to_json
    end
    logger.info("Succeeded word search")
  end

end
