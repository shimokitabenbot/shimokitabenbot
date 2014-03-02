# -*- coding: utf-8 -*-
=begin
ツイート機能のテストケース
=end
require 'spec_helper'
require 'base64'

describe TweetController, :controller => 'tweet', :action => 'twitter_free' do
  # リクエストパラメータ
  before(:each) do
    @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("name:password")
  end

  describe 'Failed' do
    it 'Empty Body' do
      post 'twitter_free'
      expect(response.status).to eq(400)
    end
  end

  describe 'Succeeded' do
    it 'succeeded' do
      post 'twitter_free', {"tweet" => "つぶやき", "hashtag" => "#つぶやきテスト"}
      expect(response.status).to eq(201)
      res_body = JSON.parse(response.body)
      expect(res_body['tweet']).to eq("つぶやき\n#つぶやきテスト\n#下北弁")
      expect(res_body['twittered_at']).not_to be_nil
    end
  end
end
