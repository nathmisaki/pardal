class CreateEnrollments < ActiveRecord::Migration
  def self.up
    create_table :enrollments do |t|
      t.belongs_to :student
      t.belongs_to :course
      t.belongs_to :situation
      t.string :grade, :limit => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :enrollments
  end
end
