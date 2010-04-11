class CreateImplementations < ActiveRecord::Migration
  def self.up
    create_table :implementations do |t|
      t.belongs_to :curriculum
      t.belongs_to :discipline
      t.integer :school_semester
      t.belongs_to :discipline_type

      t.timestamps
    end
  end

  def self.down
    drop_table :implementations
  end
end
