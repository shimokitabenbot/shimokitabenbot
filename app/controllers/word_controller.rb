# -*- coding: utf-8 -*-
=begin rdoc
単語登録、更新、削除処理を行うコントローラ
=end
require 'bot_error'
require 'bot_internal_error'
require 'empty_value_error'
require 'value_exceeded_error'
require 'empty_body_error'
class WordController < ApplicationController

  # 単語登録を行う
  def create
    logger.info('Start word regist.')
    raise EmptyBodyError if params.nil? or !params.has_key?(:description)
    logger.debug("Request Parameters : #{params}")
    begin
      logger.info('Insert record started')
      # Wordsテーブルに登録する
      record = Word.new do |w|
        w.word        = params[:word]
        w.description = params[:description]
        w.example     = params[:example]
        w.translate   = params[:translate]
        w.save!
      end
      logger.info('Insert record finished.')
      render :status => :created, :json => { "id" => record.id, "word" => record.word}.to_json
      logger.info('Succeeded word regist.')
    rescue ActiveRecord::RecordInvalid => e
      raise_error_from_invalid_record(e)
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
    if params[:word] and !params[:word].empty?
      # 単語が指定されている場合、単語検索
      if params[:match_type].nil? or params[:match_type] == 'complete'
        logger.info("Exact Match.")
        words = Word.where(:word => params[:word])
      elsif params[:match_type] == 'part'
        logger.info("Partial Match.")
        words = Word.where(["word like ?", "%#{params[:word]}%"])
      end
    else
      logger.info("Exhaustive Search.")
      # 単語が指定されていない場合、全件検索
      words = Word.all 
    end
    if words.nil? or words.empty?
      logger.info("Not found")
      # 何も返さない場合は、JSONを空にしないとエラー
      raise NotFound
    else
      logger.info("検索件数: #{words.size}")
      render :status => :ok, :json => words.to_json
    end
    logger.info("Succeeded word search")
  end

  # 単語更新を行う
  def update
    logger.info("Start word update.")
    word = nil
    begin
      if params[:id] 
        word = Word.find(params[:id])
      elsif params[:word] and !params[:word].empty?
        word = Word.where("word" => params[:word])
        logger.debug("word.ids.size=#{word.ids.size}")
        if word.ids.size == 0
          # 更新レコードがない場合
          raise NotFound
        elsif word.ids.size > 1
          # 検索件数が複数ある場合
          raise SomeWordsForUpdateError, word.to_json
        end
      else
        logger.warn("No id and word.")
        raise NoIdAndWordError
      end
      logger.debug("word = #{word}")    

      WordHst.new do |h|
        h.word_id = word.id
        h.example = params[:example]
        h.translate = params[:translate]
        h.save!
      end
      word.update({:example => params[:example], :translate => params[:translate]})
      render :status => 200, :json => word.to_json
      logger.info("Succeeded word update.")
    rescue ActiveRecord::RecordInvalid => e
      raise_error_from_invalid_record(e)
    rescue BotError => e
      raise e
    rescue NotFound => e
      raise e
    rescue => e
      logger.error(e)
      raise BotInternalError, e.message
    end
  end

# Refactoring 
private
  # ActiveRecord::RecordInvalidからスローする例外を判断する
  def raise_error_from_invalid_record(error)
    if error.message.include?("can't be blank")
      logger.error(error)
      raise EmptyValueError, error.message 
    elsif error.message.include?("too long")
      logger.error(error)
      raise ValueExceededError, error.message
    else
      logger.error(error)
      raise BotInternalError, error.message
    end
  end  
end
