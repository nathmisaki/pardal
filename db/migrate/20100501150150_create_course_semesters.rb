class CreateCourseSemesters < ActiveRecord::Migration
  def self.up
    create_table :course_semesters do |t|
      t.belongs_to :course
      t.integer :semester

      t.timestamps
    end
  end

  def self.down
    drop_table :course_semesters
  end
end
