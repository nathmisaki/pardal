require 'spec_helper'

describe Enrollment do
  context "calling proposal_for_student" do
    it 'should return an empty array for a student without disciplines' do
      @student = Student.make
      Enrollment.proposal_for_student(@student).should == []
    end

    it 'should return an array of Enrollments with the disciplines from the curriculum' do
      @student = Student.make
      discipline = Discipline.make
      discipline.courses.make(:course_school => CourseSchool.make(:school => @student.curriculum.school, :period => @student.curriculum.period)).course_semesters.make(:semester => (Time.now.year*10+((Time.now.month-1)/6+1)))
      @student.curriculum.implementations.make(:discipline => discipline)
      Enrollment.proposal_for_student(@student).map { |ep| ep.course_semester.course.discipline }.should == [discipline]
    end
  end


end
