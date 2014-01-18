class ApplicationController < ActionController::Base
  include HTTPRequestValidator

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # BASIC認証
  # Rails起動時に環境変数に以下のパラメータを設定する
  # * AUTH_USER : BASIC認証ユーザID
  # * AUTH_PASS : BASIC認証パスワード
  http_basic_authenticate_with name: ENV['AUTH_USER'], password: ENV['AUTH_PASS']
end
