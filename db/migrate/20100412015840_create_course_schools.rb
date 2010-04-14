class CreateCourseSchools < ActiveRecord::Migration
  def self.up
    create_table :course_schools do |t|
      t.belongs_to :period
      t.belongs_to :school
      t.integer :code
      t.string :symbol

      t.timestamps
    end
  end

  def self.down
    drop_table :course_schools
  end
end
