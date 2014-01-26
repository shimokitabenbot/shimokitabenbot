# -*- coding: utf-8 -*-
=begin rdoc
HTTPリクエストデータの検証を行うモジュール
=end
require 'active_support'
module HTTPRequestValidator
  extend ActiveSupport::Concern

  def validate_match_type(match_type)
    raise MatchTypeError, match_type unless match_type == 'complete' or match_type == 'part'
  end
end
