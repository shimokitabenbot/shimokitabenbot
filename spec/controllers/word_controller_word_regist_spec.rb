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

describe WordControllerWordRegist do
  # リクエストボディが空
  describe 'Empty request body' do
  end

  # リクエストボディがJSONではない
  describe 'Not JSON' do
  end

  # リクエストボディに値が存在しない
  describe 'Value not found' do
  end

  # 入力値が文字列超過した場合
  describe 'Value Exceeded' do
  end

  # 正常終了
  describe 'Succeeded' do
  end
end
