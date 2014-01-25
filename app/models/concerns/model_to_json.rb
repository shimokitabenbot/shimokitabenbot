# -*- coding: utf-8 -*-
module ModelToJSON
	class Word
    # ModelからJSONに変換する
    def self.to_json(model)
      word = {}
      word['id'] = model.id
      word['word'] = model.word
      word['description'] = model.description
      word['example'] = model.example
      word['translate'] = model.translate
      return word
    end
	end
end