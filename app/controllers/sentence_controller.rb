# -*- coding: utf-8 -*-
class SentenceController < ApplicationController

  def create
    logger.info('Start regist sentence.')
    raise EmptyBodyError if params.nil?
    record = nil
    id = 0
    begin
      record = Sentence.new do |s|
        s.sentence = params[:sentence]
        s.hashtag = params[:hashtag] 
        s.save!
      end
      logger.info('Succeed regist sentence.')
      render :status => :created, :json => record.to_json
    rescue => e
    end
  end

  def search
  end

end
