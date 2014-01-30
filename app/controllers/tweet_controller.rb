# -*- coding: utf-8 -*-
=begin
ツイート用コントローラクラス。
Twitterにつぶやく機能を持つ。
=end
require 'twitter'
require 'date'
class TweetController < ApplicationController

  MAX_RETRY_COUNT = 6

  # Twitterにつぶやく
  # HTTPリクエスト: POST
  def twitter
    # 単語を一つランダムに取得する
    tweet = nil
    retry_count = 1
    begin
      logger.info("単語検索")
      word = Word.all.sample
      tweet = word.tweet
      client = Shimokitabenbot::Application.config.client
      logger.debug("client: #{client.to_s}")
      logger.info("ツイート")
      logger.debug("内容:\n #{tweet.to_s}")
      res = client.update(tweet)
      logger.debug("result: #{res.to_s}")
      created_at = res['created_at']
      render :status => :created, :json => { "tweet" => tweet, "twittered_at" => created_at.strftime('%Y-%m-%dT%H:%M:%SZ') }.to_json
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

end
