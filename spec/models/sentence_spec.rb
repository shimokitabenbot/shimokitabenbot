# -*- coding: utf-8 -*-
require 'spec_helper'

describe Sentence do
  describe 'Invalid Record' do
    it 'sentence and hashtag are nil' do
      expect(Sentence.new).not_to be_valid
    end
    
    it 'sentence is nil' do
      s = Sentence.new
      s.hashtag = '#hashtag'
      expect(s).not_to be_valid
    end

    it 'hashtag is nil' do
      s = Sentence.new
      s.sentence = 'aaa'
      expect(s).not_to be_valid
    end

    it 'sentence is exceeded' do
      s = Sentence.new
      s.sentence = 'a' * 73
      expect(s).not_to be_valid
    end

    it 'hashtag is exceeded' do
      s = Sentence.new
      s.hashtag = 'a' * 73
      expect(s).not_to be_valid
    end

    it 'twitter chars exceeded' do
      s = Sentence.new
      s.sentence = 'a' * 70
      s.hashtag = 'a' * 70
      expect(s).not_to be_valid
    end
  end

  describe 'Succeeded' do
    it 'ok' do
      s = Sentence.new
      s.sentence = 'a' * 50
      s.hashtag = '#' + ('a' * 50)
      expect(s).to be_valid
    end
  end

end
