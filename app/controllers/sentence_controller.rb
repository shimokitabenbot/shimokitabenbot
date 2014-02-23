# -*- coding: utf-8 -*-
require 'bot_error'
require 'bot_internal_error'
require 'empty_value_error'
require 'value_exceeded_error'
require 'empty_body_error'

class SentenceController < ApplicationController

  def create
    logger.info('Start regist sentence.')
    raise EmptyBodyError if params.nil? or params.empty? or params[:sentence].nil? or params[:sentence].empty?
    record = nil
    begin
      record = Sentence.new do |s|
        s.sentence = params[:sentence]
        s.hashtag = params[:hashtag] 
        s.save!
      end
      logger.info('Succeed regist sentence.')
      render :status => :created, :json => record.to_json
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

  def search
    logger.info("Start sentence search.")

    sentences = nil
    if params[:hashtag]
      sentences = Sentence.where(["hashtag like ?", "%#{params[:hashtag]}%"])
    else
      sentences = Sentence.all
    end

    if sentences.nil? or sentences.empty?
      raise NotFound
    else
      render :status => :ok, :json => sentences.to_json
    end
    logger.info("Finish sentence search.")
  end

end
