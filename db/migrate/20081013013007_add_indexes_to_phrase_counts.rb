class AddIndexesToPhraseCounts < ActiveRecord::Migration
  def self.up
    add_index :phrase_counts, :page_id
    add_index :phrase_counts, :created_at
  end

  def self.down
    remove_index :phrase_counts, :page_id
    remove_index :phrase_counts, :created_at
  end
end
