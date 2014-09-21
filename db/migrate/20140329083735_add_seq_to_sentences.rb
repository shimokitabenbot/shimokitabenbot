class AddSeqToSentences < ActiveRecord::Migration
  def change
    add_column :sentences, :parent_id, :integer
    add_column :sentences, :url, :string, :limit => 64
    add_column :sentences, :sequence, :integer
    change_column :sentences, :sentence, :string, :limit => 128
  end
end
