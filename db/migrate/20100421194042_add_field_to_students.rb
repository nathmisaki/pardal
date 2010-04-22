class AddFieldToStudents < ActiveRecord::Migration
  def self.up
    change_table :students do |t|
      t.boolean :active
    end
  end

  def self.down
    change_table :students do |t|
      t.remove :active
    end
  end
end
