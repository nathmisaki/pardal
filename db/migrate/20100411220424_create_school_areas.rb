class CreateSchoolAreas < ActiveRecord::Migration
  def self.up
    create_table :school_areas do |t|
      t.string :name, :limit => 200

      t.timestamps
    end
  end

  def self.down
    drop_table :school_areas
  end
end
