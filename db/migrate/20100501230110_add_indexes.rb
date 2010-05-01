class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :students, :registration
    add_index :students, :curriculum_id
    add_index :users, :email
    add_index :helps, :page
    add_index :course_schools, :period_id
    add_index :course_schools, :school_id
    add_index :course_semesters, :course_id
    add_index :courses, :discipline_id
    add_index :courses, :course_school_id
    add_index :curriculums, :school_id
    add_index :curriculums, :period_id
    add_index :disciplines, :department_id
    add_index :enrollments, :student_id
    add_index :enrollments, :situation_id
    add_index :enrollments, :course_semester_id
    add_index :implementations, :curriculum_id
    add_index :implementations, :discipline_id
    add_index :implementations, :discipline_type_id
    add_index :implementations, :school_semester
    add_index :roles, :authorizable_type
    add_index :roles, :authorizable_id
    add_index :roles_users, :user_id
    add_index :roles_users, :role_id
    add_index :schools, :school_area_id

  end

  def self.down
    remove_index :students, :registration
    remove_index :students, :curriculum_id
    remove_index :users, :email
    remove_index :helps, :page
    remove_index :course_schools, :period_id
    remove_index :course_schools, :school_id
    remove_index :course_semesters, :course_id
    remove_index :courses, :discipline_id
    remove_index :courses, :course_school_id
    remove_index :curriculums, :school_id
    remove_index :curriculums, :period_id
    remove_index :disciplines, :department_id
    remove_index :enrollments, :student_id
    remove_index :enrollments, :situation_id
    remove_index :enrollments, :course_semester_id
    remove_index :implementations, :curriculum_id
    remove_index :implementations, :discipline_id
    remove_index :implementations, :discipline_type_id
    remove_index :implementations, :school_semester
    remove_index :roles, :authorizable_type
    remove_index :roles, :authorizable_id
    remove_index :roles_users, :user_id
    remove_index :roles_users, :role_id
    remove_index :schools, :school_area_id
  end
end
