# -*- coding: utf-8 -*-
=begin rdoc
HTTPリクエストデータの検証を行うモジュール
=end
require 'active_support'
require 'match_type_error'
module HTTPRequestValidator
  extend ActiveSupport::Concern
  include Shimokitabenbot

  def validate_match_type(match_type)
    raise MatchTypeError, match_type unless match_type == 'complete' or match_type == 'part'
  end
end
