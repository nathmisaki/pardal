# == Schema Information
#
# Table name: courses
#
#  id               :integer(4)      not null, primary key
#  discipline_id    :integer(4)
#  course_school_id :integer(4)
#  grade_list_qty   :integer(4)
#  has_grade_list   :boolean(1)
#  divide_class     :boolean(1)
#  created_at       :datetime
#  updated_at       :datetime
#

class Course < ActiveRecord::Base
  belongs_to :discipline
  belongs_to :course_school
  has_many :course_semesters

  def current_course_semester
    course_semesters.find_by_semester Time.now.year_semester
  end
end
