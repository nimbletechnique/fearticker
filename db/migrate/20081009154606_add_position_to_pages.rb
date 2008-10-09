class AddPositionToPages < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.integer :position
    end
  end

  def self.down
    change_table :pages do |t|
      t.remove :position
    end
  end
end
