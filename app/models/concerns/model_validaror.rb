# -*- coding: utf-8 -*-
module ModelValidator
  class Word
    # exampleとtranslateのいずれかがnil/emptyでないかどうか検証する
    def self.validates_example_and_translate(example, translate)
      if example.nil? or example.empty?
        errors.add(:example, "Example can't be blank.") unless translate.nil? or translate.empty?
      elsif translate.nil? or translate.empty?
        errors.add(:translate, "Translate can't be blank.") unless translate.nil? or example.empty?
      end
    end
  end
end