# -*- coding: utf-8 -*-
=begin rdoc
単語登録、更新、削除処理を行うコントローラ
=end
require 'bot_error'
class WordController < ApplicationController

  # 単語登録を行う
  def create
    logger.info('Start word regist.')
      body = request.body

    # Wordsテーブルに登録する
    id = 0
    logger.debug("#{params[:word]}, #{params[:decription]}, #{params[:example]}, #{params[:translate]}")
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
  end

  # 単語検索を行う
  def search
    
  end

end
