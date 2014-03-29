# -*- coding: utf-8 -*-
class WordHistoryController < ApplicationController
  def search
    begin
      history = WordHst.where("word_id = ?", params[:word_id])
      if history.nil? or history.empty?
        raise NotFound
      else
        word = (Word.find_by_id(id: params[:word_id]))["word"]
        render :status => :ok, :json => to_json_for_search(word, history)
      end
    rescue NotFound => e
      raise e
    rescue => e
      logger.error(e)
      raise BotInternalError, e.message
    end
  end

private
  def to_json_for_search(word, history)
    histories = []
    history.each do |h|
      histories << {"example" => h["example"], "translate" => h["translate"]}
    end
    return {"word_id" => history.word_id, "word" => word, "histories" => histories}.to_json
  end
end