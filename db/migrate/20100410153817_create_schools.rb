class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.string :name, :limit => 120
      t.string :acronym, :limit => 15
      t.belongs_to :school_area

      t.timestamps
    end
  end

  def self.down
    drop_table :schools
  end
end
