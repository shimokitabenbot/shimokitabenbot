# -*- coding: utf-8 -*-
require 'bot_error'
require 'not_found'
class ApplicationController < ActionController::Base
  include HTTPRequestValidator
  include Shimokitabenbot
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # BASIC認証
  # Rails起動時に環境変数に以下のパラメータを設定する
  # * AUTH_USER : BASIC認証ユーザID
  # * AUTH_PASS : BASIC認証パスワード
  http_basic_authenticate_with name: ENV['AUTH_USER'], password: ENV['AUTH_PASS']

  # 例外ハンドル
  rescue_from BotError do |err|
    render :status => err.status, :json => err.to_json
  end

  rescue_from NotFound do |err|
    render :status => 404, :json => {}
  end
end
