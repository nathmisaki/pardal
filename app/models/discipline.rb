# == Schema Information
#
# Table name: disciplines
#
#  id            :integer(4)      not null, primary key
#  code          :integer(4)
#  name          :string(120)
#  department_id :integer(4)
#  acronym       :string(30)
#  credit_hours  :integer(1)
#  created_at    :datetime
#  updated_at    :datetime
#

class Discipline < ActiveRecord::Base
  belongs_to :department
  has_many :implementations
  has_many :curriculums, :through => :implementations
  has_many :courses

  def courses_from_curriculum(curriculum)
    courses.all :joins => :course_school,
      :conditions => ["course_schools.school_id  = ? AND course_schools.period_id = ?",
        curriculum.school_id, curriculum.period_id]
  end
end
