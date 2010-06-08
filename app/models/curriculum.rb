# == Schema Information
#
# Table name: curriculums
#
#  id                      :integer(4)      not null, primary key
#  school_id               :integer(4)
#  period_id               :integer(4)
#  curriculum_type         :integer(4)
#  implementation_semester :integer(4)
#  created_at              :datetime
#  updated_at              :datetime
#  credit_hours            :integer(4)
#  avg_school_time         :integer(4)
#  max_school_time         :integer(4)
#  structure_code          :integer(4)
#

class Curriculum < ActiveRecord::Base
  belongs_to :school
  belongs_to :period
  has_many :implementations
  has_many :disciplines, :through => :implementations
  has_many :courses, :through => :disciplines

  def course_schools
    CourseSchool.all(:conditions => ["school_id = ? and period_id = ?", school_id, period_id])
  end
end
