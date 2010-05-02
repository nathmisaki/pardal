class Discipline < ActiveRecord::Base
  belongs_to :department
  has_many :implementations
  has_many :courses

  def courses_from_curriculum(curriculum)
     if curriculum
       courses.find(:all, :joins => :course_school,
                 :conditions => ["course_schools.school_id  = ? AND course_schools.period_id = ?",
                   curriculum.school_id, curriculum.period_id])
     else
       []
     end
  end
end
