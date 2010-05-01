require 'spec_helper'

describe Curriculum do

  it 'should return course_schools' do
    curriculum = Curriculum.make
    course_schools = (1..10).to_a.map { CourseSchool.make(:school => curriculum.school, :period => curriculum.period) }

    curriculum.course_schools.each do |course_school|
      course_schools.should include(course_school)
    end
  end
end
