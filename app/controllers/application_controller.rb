# -*- coding: utf-8 -*-
require 'bot_error'
require 'active_record/errors'
class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # BASIC認証
  # Rails起動時に環境変数に以下のパラメータを設定する
  # * AUTH_USER : BASIC認証ユーザID
  # * AUTH_PASS : BASIC認証パスワード
  http_basic_authenticate_with name: ENV['AUTH_USER'], password: ENV['AUTH_PASS']

  # 例外ハンドル
#  rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid_error
  rescue_from ActiveRecord::RecordInvalid do |err|
    record_invalid_error(err)
  end

  rescue_from EmptyBodyError, :with => :empty_body_error 

protected
  def record_invalid_error(exception = nil)
    logger.info("error message: #{exception.message}")
    if exception.message.include?("can't be blank")
      e = EmptyValueError.new(exception.message)
      render :status => e.status, :json => e.json
    else
      e = ValueExceededError.new(exception.message)
      render :status => e.status, :json => e.json
    end
  end

  def empty_body_error(exception = nil)
    render :status => exception.status, :json => exception.json
  end
end
