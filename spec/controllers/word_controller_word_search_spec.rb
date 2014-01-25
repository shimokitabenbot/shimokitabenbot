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
  before(:all) do
    # テストデータ追加は1回だけ
  end
  before(:each) do
    # リクエストパラメータ設定
  end

  after(:all) do
    # テストデータ削除は1回だけ
  end

  # 検索条件間違い
  describe 'Wrong match type' do
  end

  # 単語が見つからない
  describe 'Word not found' do
  end

  # 単語検索(完全一致：パラメータ指定なし)
  describe 'word completed no param' do
  end

  # 単語検索(完全一致：パラメータ指定あり)
  describe 'word completed param exist' do
  end

  # 単語検索(部分一致)
  describe 'word parted' do
  end

  # 全単語検索
  describe 'all' do
  end

end