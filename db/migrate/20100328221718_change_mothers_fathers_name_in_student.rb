class ChangeMothersFathersNameInStudent < ActiveRecord::Migration
  def self.up
    change_table :students do |t|
      t.rename :mother_name, :mothers_name
      t.rename :father_name, :fathers_name
    end
  end

  def self.down
    change_table :students do |t|
      t.rename :mothers_name, :mother_name
      t.rename :fathers_name, :father_name
    end
  end
end
