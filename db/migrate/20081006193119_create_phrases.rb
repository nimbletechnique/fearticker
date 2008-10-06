class CreatePhrases < ActiveRecord::Migration
  def self.up
    create_table :phrases do |t|
      t.string :text
      t.timestamps
    end
    
    add_index :phrases, :text
    
  end

  def self.down
    drop_table :phrases
  end
end
