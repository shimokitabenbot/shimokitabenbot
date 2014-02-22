# -*- coding: utf-8 -*-
=begin
ツイート用コントローラクラス。
Twitterにつぶやく機能を持つ。
=end
require 'twitter'
require 'date'
require 'bot_database_error'
require 'twitter_failed_error'
class TweetController < ApplicationController
  include Shimokitabenbot

  MAX_RETRY_COUNT = 6

  # Twitterにつぶやく
  # HTTPリクエスト: POST
  def twitter
    # 単語を一つランダムに取得する
    tweet = nil
    retry_count = 1
    max_id = Word.maximum(:id) # 呼び出しは1回だけ
    begin
      logger.info("単語検索")
      word = find_word(max_id)
      tweet = word.tweet
      client = Application.config.client
      logger.debug("client: #{client.to_s}")
      logger.info("ツイート")
      logger.debug("内容:\n #{tweet.to_s}")
      res = client.update(tweet)
      logger.debug("result: #{res.to_s}")
      created_at = res['created_at']
      word.last_twittered_at = created_at
      word.save!
      render :status => :created, :json => { "tweet" => tweet, "twittered_at" => created_at.strftime('%Y-%m-%dT%H:%M:%SZ') }.to_json
    rescue NoMethodError => e
      logger.warn("Word is not found.")
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

private
  def generate_id(max_id)
    return rand(max_id) + 1
  end

  def find_word(max_id)
    max_id.times do
      id = generate_id(max_id)
      word = Word.find_by(id: id)
      return word if can_twitter(word.last_twittered_at)
    end
  end

  def can_twitter(last_twittered_at)
    logger.debug(last_twittered_at)
    return true if last_twittered_at.nil?
    logger.debug("utc: #{Time.current.utc}")
    logger.debug("config.twitter_duration: #{Application.config.twitter_duration}")
    return true if Time.current.utc - last_twittered_at > Application.config.twitter_duration
    return false
  end

end
