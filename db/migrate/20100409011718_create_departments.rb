class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.string :name, :limit => 150
      t.string :acronym, :limit => 20

      t.timestamps
    end
  end

  def self.down
    drop_table :departments
  end
end
