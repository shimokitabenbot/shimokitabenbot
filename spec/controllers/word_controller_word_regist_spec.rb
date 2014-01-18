# -*- coding: utf-8 -*-
=begin
単語登録機能のテストケース
テストパターンは以下の通り。
* リクエストボディが空
* リクエストボディがJSONではない
* リクエストボディに値が存在しない
* 入力値が文字列超過した場合
* 正常終了
=end
require 'spec_helper'
require 'base64'

describe WordController, :controller => 'words' do

  before(:each) do
    @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("name:password")
    @request.env['CONTENT_TYPE'] = 'application/json'
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
      param = {"word"=>"", "description" => "わたし", 
              "example" => "わいがモテないのはどう考えてもおめだぢが悪い。",
              "translate" => "私がモテないのはどう考えてもおまえらが悪い。"}
      post 'create', param.to_json
      expect(response.status).to eq(400)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).not_to be_nil
      expect(err['code']).to eq('11000003')
      expect(err['message']).to eq('empty_val')
      expect(err['detail']).not_to be_nil
    end
  end

  # 入力値が文字列超過した場合
  describe 'Value Exceeded' do
    it 'word is exceeded' do
      wrd = "a" * 17
      param = {"word"=>wrd, "description" => "わたし",
              "example" => "わいがモテないのはどう考えてもおめだぢが悪い。",
              "translate" => "私がモテないのはどう考えてもおまえらが悪い。"}
      post 'create', param.to_json
      expect(response.status).to eq(400)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).not_to be_nil
      expect(err['code']).to eq('11000003')
      expect(err['message']).to eq('val_exceeded')
      expect(err['detail']).not_to be_nil
    end

  end

  # 正常終了
  describe 'Succeeded' do
    it 'suceeded' do
      param = {"word"=>"わい", "description" => "わたし",
              "example" => "わいがモテないのはどう考えてもおめだぢが悪い。",
              "translate" => "私がモテないのはどう考えてもおまえらが悪い。"}
      post 'create', param.to_json
      expect(response.status).to eq(201)
      res_body = JSON.parse(response.body)
      id = res_body['id']
      expect(id).not_to be_nil
      word = res_body['word']
      expect(word).to eq('わい')
    end
  end
end
