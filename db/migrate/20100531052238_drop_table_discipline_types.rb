class DropTableDisciplineTypes < ActiveRecord::Migration
  def self.up
    drop_table :discipline_types
  end

  def self.down
    create_table :discipline_types do |t|
      t.string :name, :limit => 25

      t.timestamps
    end
  end
end
