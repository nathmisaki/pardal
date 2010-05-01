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
