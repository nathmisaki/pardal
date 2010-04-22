class AddMilitaryIdentificationToStudents < ActiveRecord::Migration
  def self.up
    change_table :students do |t|
      t.string :military_identification, :limit => 30
    end
  end

  def self.down
    change_table :students do |t|
      t.remove :military_identification
    end
  end
end
