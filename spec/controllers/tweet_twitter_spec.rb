# -*- coding: utf-8 -*-
=begin
ツイート機能のテストケース
テストパターンは以下の通り。
* (Twitterにアクセスできない) -> 実際に再現できないのでやらない
* (Twitterにツイート失敗) -> 実際に再現できないのでやらない
* 正常終了
=end
require 'spec_helper'
require 'base64'

describe TweetController, :controller => 'tweet', :action => 'twitter' do
  fixtures :word, :sentence
  # リクエストパラメータ
  before(:each) do
    @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("name:password")
  end

  after(:all) do
    Word.destroy_all
    Sentence.destroy_all
  end

  describe 'Succeeded' do
    it 'succeeded' do
      post 'twitter'
      expect(response.status).to eq(201)
      res_body = JSON.parse(response.body)
      expect(res_body['tweet']).not_to be_nil
      expect(res_body['twittered_at']).not_to be_nil
    end
  end
end
