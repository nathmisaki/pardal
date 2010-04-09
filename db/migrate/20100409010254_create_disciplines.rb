class CreateDisciplines < ActiveRecord::Migration
  def self.up
    create_table :disciplines do |t|
      t.integer :code
      t.string :name, :limit => 120
      t.belongs_to :department
      t.string :acronym, :limit => 30
      t.integer :credit_hours, :limit => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :disciplines
  end
end
