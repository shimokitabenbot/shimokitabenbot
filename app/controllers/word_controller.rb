# -*- coding: utf-8 -*-
=begin rdoc
単語登録、更新、削除処理を行うコントローラ
=end
require 'bot_error'
class WordController < ApplicationController

  # 単語登録を行う
  def create
    logger.info('Start word regist.')
    logger.debug("params.nil? #{params.nil?}")
    logger.debug("!params.has_key?(:description) #{!params.has_key?(:description)}")
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
      raise EmptyValueError, e.message if e.message.include?("can't be blank")
      raise ValueExceededError, e.message if e.message.include?("too long")
    end
  end

  # 単語検索を行う
  def search
    
  end

end
