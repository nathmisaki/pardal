require 'spec_helper'

describe Discipline do
  it 'should return only courses from the curriculum' do
    cur = Curriculum.make
    discipline = Discipline.make
    discipline.courses.make
    cur.implementations.make :discipline => discipline
    courses_from_curriculum = (1..10).to_a.map do 
      discipline.courses.make :course_school => CourseSchool.make(:school => cur.school, :period => cur.period)
    end
    
    discipline.courses_from_curriculum(cur).each do |course|
      courses_from_curriculum.should include(course)
    end

  end
end
