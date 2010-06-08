# == Schema Information
#
# Table name: course_semesters
#
#  id         :integer(4)      not null, primary key
#  course_id  :integer(4)
#  semester   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class CourseSemester < ActiveRecord::Base
  belongs_to :course
  has_many :course_schedules

  named_scope :only_current_semester, :conditions => { :semester => Time.now.year_semester }

  named_scope :courses_in, lambda { |*courses|
    courses.flatten!
    courses.map!(&:id) if courses.first.is_a?(Course)
    { :conditions => { :course_id => courses } }
  }

  named_scope :including_course_and_discipline, :include => [:course => :discipline]
end
