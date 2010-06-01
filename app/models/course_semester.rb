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
