class MigratingEnrollmentRelationshipCourseSemester < ActiveRecord::Migration
  def self.up
    rename_column :enrollments, :course_id, :course_semester_id
  end

  def self.down
    rename_column :enrollments, :course_semester_id, :course_id
  end
end
