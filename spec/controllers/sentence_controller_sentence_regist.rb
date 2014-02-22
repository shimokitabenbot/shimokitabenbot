# -*- coding: utf-8 -*-
=begin
例文登録機能のテストケース
テストパターンは以下の通り。
* リクエストボディが空
* リクエストボディがJSONではない
* リクエストボディに値が存在しない
* 入力値が文字列超過した場合
* 正常終了
=end
require 'spec_helper'
require 'base64'

describe SentenceController, :controller => 'sentences' do

  # リクエストパラメータ
  before(:each) do
    @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("name:password")
    @request.env['CONTENT_TYPE'] = 'application/json'
  end

  # レコード削除
  after(:all) do
    Sentence.destroy_all
  end

  describe 'Empty request body' do
    # リクエストボディが空
    it 'bad request' do  
      post 'create' 

      expect(response.status).to eq(400)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).not_to be_nil
      expect(err['code']).to eq('11000001')
      expect(err['message']).to eq('empty_body')
      expect(err['detail']).to be_nil
    end
  end

  # リクエストボディに値が存在しない
  describe 'Value not found' do
    it 'word is empty' do
      params = {"sentence"=>"", "hashtag" => "わたし"}
      post 'create', params
      expect(response.status).to eq(400)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).not_to be_nil
      expect(err['code']).to eq('11000003')
      expect(err['message']).to eq('empty_value')
      expect(err['detail']).to eq("Validation failed: Sentence can't be blank")
    end
  end

  describe 'Value Exceeded' do
    it 'sentence is exceeded' do
      snt = "a" * 73
      params = {"sentence"=>snt, "hashtag" => "わたし"}
      post 'create', params
      expect(response.status).to eq(400)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).not_to be_nil
      expect(err['code']).to eq('11000003')
      expect(err['message']).to eq('value_exceeded')
      expect(err['detail']).to eq("Validation failed: Sentence is too long (maximum is 72 characters)")
    end
  end

  # 正常終了
  describe 'Succeeded' do
    it 'suceeded' do
      params = {"sentence"=>"わいだっきゃほいどでねぇ。", "hashtag" => "#方言で私は乞食ではありませんとつぶやいてください"}
      post 'create', params
      expect(response.status).to eq(201)
      res_body = JSON.parse(response.body)
      id = res_body['id']
      expect(id).not_to be_nil
      snt = res_body['sentence']
      expect(word).to eq('わいだっきゃほいどでねぇ。')
    end
  end
end
