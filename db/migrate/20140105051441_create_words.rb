# -*- coding: utf-8 -*-
=begin rdoc
Wordsテーブルを作成する
=end
class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word, :limit => 16, :null => false
      t.string :description, :limit => 32, :null => false
      t.string :example, :limit => 64
      t.string :translate, :limit => 64

      t.timestamps
    end
  end
end
