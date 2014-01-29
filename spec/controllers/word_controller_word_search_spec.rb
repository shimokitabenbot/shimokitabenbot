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
  fixtures :word
  before(:each) do
    # リクエストパラメータ設定
    @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("name:password")
  end

  after(:all) do
    # テストデータ削除は1回だけ
   Word.destroy_all
  end

  # 検索条件間違い
  describe 'Wrong match type' do
    it 'Match type is "none"' do
      get 'search', {:word => "おめ", :match_type => "none"}
      expect(response.status).to eq(400)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).not_to be_nil
      expect(err['code']).to eq('11000003')
      expect(err['message']).to eq('match_type_error')
      expect(err['detail']).to eq('none')
    end
  end

  # 単語が見つからない
  describe 'Word not found' do
    it 'Word not found' do
      get 'search', {:word => "にほん"}
      expect(response.status).to eq(404)
      res_body = JSON.parse(response.body)
      err = res_body['error']
      expect(err).to be_nil
    end
  end

  # 単語検索(完全一致：パラメータ指定なし)
  describe 'word completed no param' do
    it 'Word is found' do
      get 'search', {:word => "しかへる"}
      expect(response.status).to eq(200)
      res_body = JSON.parse(response.body)
      expect(res_body[0]['word']).to eq('しかへる')
      expect(res_body[0]['description']).to eq('教える')
      expect(res_body[0]['example']).to eq('しかへで、エライ人。')
      expect(res_body[0]['translate']).to eq('教えて、エライ人。')
    end
  end

  # 単語検索(完全一致：パラメータ指定あり)
  describe 'word completed param exist' do
    it 'Word is found' do
      get 'search', {:word => "しかへる", :match_type => 'complete'}
      expect(response.status).to eq(200)
      res_body = JSON.parse(response.body)
      expect(res_body[0]['word']).to eq('しかへる')
      expect(res_body[0]['description']).to eq('教える')
      expect(res_body[0]['example']).to eq('しかへで、エライ人。')
      expect(res_body[0]['translate']).to eq('教えて、エライ人。')
    end
  end

  # 単語検索(部分一致)
  describe 'word parted' do
    it 'Word is found' do
      get 'search', {:word => "かへ", :match_type => 'part'}
      expect(response.status).to eq(200)
      res_body = JSON.parse(response.body)
      expect(res_body[0]['word']).to eq('しかへる')
      expect(res_body[0]['description']).to eq('教える')
      expect(res_body[0]['example']).to eq('しかへで、エライ人。')
      expect(res_body[0]['translate']).to eq('教えて、エライ人。')
    end
  end

  # 全単語検索
  describe 'all' do
    it 'Words are found' do
      get 'search'
      expect(response.status).to eq(200)
      res_body = JSON.parse(response.body)
      expect(res_body.size).to eq(3) 
      expect(res_body[0]['word']).to eq('しかへる')
      expect(res_body[0]['description']).to eq('教える')
      expect(res_body[0]['example']).to eq('しかへで、エライ人。')
      expect(res_body[0]['translate']).to eq('教えて、エライ人。')

      expect(res_body[1]['word']).to eq('わらし')
      expect(res_body[1]['description']).to eq('こども')
      expect(res_body[1]['example']).to eq('わらしめんけ。')
      expect(res_body[1]['translate']).to eq('こどもかわいい。')

      expect(res_body[2]['word']).to eq('おめ')
      expect(res_body[2]['description']).to eq('あなた')
      expect(res_body[2]['example']).to eq('おめどなあ。')
      expect(res_body[2]['translate']).to eq('おまえらなあ。')
    end
  end

end
