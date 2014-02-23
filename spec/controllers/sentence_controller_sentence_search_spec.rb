# -*- coding: utf-8 -*-
=begin
単語検索機能のテストケース
テストパターンは以下の通り。
* 検索条件が間違っている
* 単語が存在しない
* 単語検索(完全一致：パラメータ指定なし)
* 単語検索(完全一致：パラメータ指定あり)
* 単語検索(部分一致)
* 全単語検索
=end
require 'spec_helper'
require 'base64'

describe SentenceController, :controller => 'sentences' do
  fixtures :sentence
  before(:each) do
    # リクエストパラメータ設定
    @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("name:password")
  end

  after(:all) do
    # テストデータ削除は1回だけ
   Sentence.destroy_all
  end

  # 文が見つからない
  describe 'Sentence not found' do
    it 'Sentence not found' do
      get 'search', {:hashtag => "にほん"}
      expect(response.status).to eq(404)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).to be_nil
    end
  end

  # 文検索(ハッシュタグ指定あり)
  describe 'search with hash tag' do
    it 'Sentence is found' do
      get 'search', {:hashtag => "#方言で教える"}
      expect(response.status).to eq(200)
      res_body = JSON.parse(response.body)
      expect(res_body[0]['sentence']).to eq('しかへる。')
      expect(res_body[0]['hashtag']).to eq('#方言で教える')
    end
  end


  # 全文検索
  describe 'all sentences' do
    it 'Sentences are found' do
      get 'search'
      expect(response.status).to eq(200)
      res_body = JSON.parse(response.body)
      expect(res_body[0]['sentence']).to eq('しかへる。')
      expect(res_body[0]['hashtag']).to eq('#方言で教える')
      expect(res_body[1]['sentence']).to eq('いらね。')
      expect(res_body[1]['hashtag']).to eq('#方言でいらない')
    end
  end
end
