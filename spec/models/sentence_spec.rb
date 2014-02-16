# -*- coding: utf-8 -*-
require 'spec_helper'

describe Sentence do
  describe 'Invalid Record' do
    it 'sentence is nil' do
      expect(Sentence.new).not_to be_valid
    end
  end

end
