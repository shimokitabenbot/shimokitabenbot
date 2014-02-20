class AddLastTwitteredAtToWords < ActiveRecord::Migration
  def change
    add_column :words, :last_twittered_at, :datetime
  end
end
