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

  describe 'Empty request body' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("name:password")
      request.env['CONTENT_TYPE'] = 'application/json'
    end

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

  # リクエストボディがJSONではない
  context 'Not JSON' do
  end

  # リクエストボディに値が存在しない
  context 'Value not found' do
  end

  # 入力値が文字列超過した場合
  context 'Value Exceeded' do
  end

  # 正常終了
  context 'Succeeded' do
  end
end
