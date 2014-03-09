# -*- coding: utf-8 -*-
=begin
ツイート用コントローラクラス。
Twitterにつぶやく機能を持つ。
=end
require 'twitter'
require 'date'
require 'bot_database_error'
require 'twitter_failed_error'
require 'empty_body_error'
class TweetController < ApplicationController
  include Shimokitabenbot

  MAX_RETRY_COUNT = 6

  # Twitterにつぶやく
  # HTTPリクエスト: POST
  def twitter
    # 単語を一つランダムに取得する
    tweet = nil
    retry_count = 1

    word_max_id = Word.maximum(:id) # 呼び出しは1回だけ
    snt_max_id = Sentence.maximum(:id)
    begin
      logger.info("単語検索")
      record = find_record(word_max_id, snt_max_id)
      tweet = record.tweet
      client = Application.config.client
      logger.debug("client: #{client.to_s}")
      logger.info("ツイート")
      logger.debug("内容:\n #{tweet.to_s}")
      res = client.update(tweet)
      logger.debug("result: #{res.to_s}")
      created_at = res['created_at']
      record.last_twittered_at = created_at
      record.save!
      render :status => :created, :json => { "tweet" => tweet, "twittered_at" => created_at.strftime('%Y-%m-%dT%H:%M:%SZ') }.to_json
    rescue NoMethodError => e
      logger.warn("Record is not found.")
      if retry_count < MAX_RETRY_COUNT
        retry_count += 1
        sleep 10
        retry
      else
        logger.error("Tweet Failed.")
        raise BotInternalError, tweet
      end
    rescue ActiveRecord::ActiveRecordError => e
      logger.error(e)
      raise BotDatabaseError, e.message
    rescue Twitter::Error::ServiceUnavailable => e
      logger.error(e)
      raise AccessUnabledError, e.message
    rescue Twitter::Error::AlreadyPosted => e
      logger.warn("Already posted: #{tweet}")
      if retry_count < MAX_RETRY_COUNT
        retry_count += 1
        sleep 10
        retry
      else
        logger.error("Tweet Failed.")
        raise TwitterFailedError, tweet
      end
    rescue Twitter::Error=> e
      logger.error(e)
      raise TwitterFailedError, tweet
    end
  end

  def twitter_free
    raise EmptyBodyError if params[:tweet].nil? or params[:tweet].empty?

    begin
      client = Application.config.client
      tweet = "#{params[:tweet]}\n#{params[:hashtag]}\n#下北弁"
      logger.debug("内容:\n #{tweet}")
      res = client.update(tweet)
      logger.debug("result: #{res.to_s}")
      created_at = res['created_at']
      render :status => :created, :json => { "tweet" => tweet, "twittered_at" => created_at.strftime('%Y-%m-%dT%H:%M:%SZ') }.to_json
    rescue Twitter::Error::ServiceUnavailable => e
      logger.error(e)
      raise AccessUnabledError, e.message
    rescue Twitter::Error=> e
      logger.error(e)
      raise TwitterFailedError, tweet
    end

  end

private
  def generate_id(max_id)
    return rand(max_id) + 1
  end

  def find_record(word_max_id, snt_max_id)
    max_id = word_max_id + snt_max_id
    last_date = Time.current.utc.days_ago(Application.config.twitter_duration).strftime('%Y-%m-%d %H:%M:%S')
    max_id.times do
      record = nil
      if generate_id(max_id) > word_max_id
        # こっちはsentenceからIDだけ取得
        id = Sentence.select("id").where("last_twittered_at is null or last_twittered_at < '#{last_date}'").sample
        continue unless id
        record = Sentence.find_by(id: id)
      else
        # こっちはwordからIDだけ取得
        id = Word.select("id").where("last_twittered_at is null or last_twittered_at < '#{last_date}'").sample
        continue unless id
        record = Word.find_by(id: id)
      end
      return record
    end
  end
end
