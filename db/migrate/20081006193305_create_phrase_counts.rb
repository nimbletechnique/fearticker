class CreatePhraseCounts < ActiveRecord::Migration
  def self.up
    create_table :phrase_counts do |t|
      t.integer :phrase_id
      t.integer :page_id
      t.integer :count
      t.timestamps
    end
  end

  def self.down
    drop_table :phrase_counts
  end
end
