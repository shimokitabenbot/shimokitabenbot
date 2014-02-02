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

describe WordController, :controller => 'words' do
  set_fixture_class :word_update => Word
  fixtures :word_update
  before(:each) do
    # リクエストパラメータ設定
    @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("name:password")
  end

  after(:all) do
    # テストデータ削除は1回だけ
   Word.destroy_all
  end

  # Bad Request
  describe 'Bad Request' do
    it 'No Id and Word empty' do
      put 'update', {:word => "", :id => nil}
      expect(response.status).to eq(400)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).not_to be_nil
      expect(err['code']).to eq('11000003')
      expect(err['message']).to eq('no_id_and_word')
      expect(err['detail']).to be_nil
    end
    it 'No Id and Word null' do
      put 'update', {:word => nil, :id => nil}
      expect(response.status).to eq(400)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).not_to be_nil
      expect(err['code']).to eq('11000003')
      expect(err['message']).to eq('no_id_and_word')
      expect(err['detail']).to be_nil
    end
    it 'some words' do
      put 'update', {:word => "ふくし", :example => "ふくす", :translate => "ふくす"}
      expect(response.status).to eq(400)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).not_to be_nil
      expect(err['code']).to eq('11000003')
      expect(err['message']).to eq('some_words_for_update')
      expect(err['detail']).not_to be_nil
    end

  end

  # 単語が見つからない
  describe 'Word not found' do
    it 'Word not found' do
      put 'update', {:word => "にほん"}
      expect(response.status).to eq(404)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).to be_nil
    end
  end

  # 単語更新
  describe 'word update' do
    it 'key = id' do
      word = Word.where("word" => "しかへる")
      puts word
      put 'update', {:id => word.ids[0], :word => nil, :example => "おめの嫁しかへろじゃ。", :translate => "お前の嫁教えろよ。"}
      expect(response.status).to eq(200)
      res_body = JSON.parse(response.body)
      expect(res_body['word']).to eq('しかへる')
      expect(res_body['description']).to eq('教える')
      expect(res_body['example']).to eq('おめの嫁しかへろじゃ。')
      expect(res_body['translate']).to eq('お前の嫁教えろよ。')
    end

    it 'key = word' do
      put 'update', {:id => nil, :word => "わい", :example => "わいどの音楽。", :translate => "僕らの音楽。"}
      expect(response.status).to eq(200)
      res_body = JSON.parse(response.body)
      expect(res_body['word']).to eq('わい')
      expect(res_body['description']).to eq('私。僕。俺。')
      expect(res_body['example']).to eq('わいどの音楽。')
      expect(res_body['translate']).to eq('僕らの音楽。')
    end
  end

end
