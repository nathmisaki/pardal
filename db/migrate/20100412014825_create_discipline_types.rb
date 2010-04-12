class CreateDisciplineTypes < ActiveRecord::Migration
  def self.up
    create_table :discipline_types do |t|
      t.string :name, :limit => 25

      t.timestamps
    end
  end

  def self.down
    drop_table :discipline_types
  end
end
