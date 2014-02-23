# -*- coding: utf-8 -*-
class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string :sentence, :limit => 72, :null => false
      t.string :hashtag,  :limit => 72, :null => false
      t.datetime :last_twittered_at
      t.timestamps
    end
  end
end
