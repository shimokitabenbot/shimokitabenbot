# -*- coding: utf-8 -*-
require 'spec_helper'

describe Word do
  describe 'all columns were empty' do
    it 'invalid' do
      expect(Word.new).not_to be_valid
    end
  end

  describe 'word was nil' do
    w = Word.new
    w.description = 'a'
    w.example = 'a'
    w.translate = 'a'
    it 'invalid' do
      expect(w).not_to be_valid
    end
  end

  describe 'description was nil' do
    w = Word.new
    w.word = 'a'
    w.example = 'a'
    w.translate = 'a'
    it 'invalid' do
      expect(w).not_to be_valid
    end
  end

  describe 'word was empty' do
    w = Word.new
    w.word = ''
    w.description = 'a'
    w.example = 'a'
    w.translate = 'a'
    it 'invalid' do
      expect(w).not_to be_valid
    end
  end

  describe 'description was empty' do
    w = Word.new
    w.word = 'a'
    w.description = ''
    w.example = 'a'
    w.translate = 'a'
    it 'invalid' do
      expect(w).not_to be_valid
    end
  end

  describe 'example and translate were nil' do
    w = Word.new
    w.word = 'a'
    w.description = 'a'
    it 'valid' do
      expect(w).to be_valid
    end
  end

  describe 'example and translate were empty' do
    w = Word.new
    w.word = 'a'
    w.description = 'a'
    w.example = ''
    w.translate = ''
    it 'valid' do
      expect(w).to be_valid
    end
  end

  describe 'example was empty  and translate was not empty' do
    w = Word.new
    w.word = 'a'
    w.description = 'a'
    w.example = ''
    w.translate = 'a'
    it 'invalid' do
      expect(w).to be_invalid
    end
  end

  describe 'example was not empty and translate was empty' do
    w = Word.new
    w.word = 'a'
    w.description = 'a'
    w.example = 'a'
    w.translate = ''
    it 'invalid' do
      expect(w).to be_invalid
    end
  end

  describe 'all values were not nil' do
    w = Word.new
    w.word = 'a'
    w.description = 'a'
    w.example = 'a'
    w.translate = 'a'
    it 'valid' do
      expect(w).to be_valid
    end
  end

  describe 'all columns were exceed' do
    w = Word.new
    w.word = 'a' * 17
    w.description = 'a' * 17
    w.example = 'a' * 33
    w.translate = 'a' * 33
    it 'invalid' do
      expect(w).to be_invalid
    end
  end
end
