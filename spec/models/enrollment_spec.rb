require 'spec_helper'

describe Enrollment do

  context "#course_semester_in Named Scope" do
    before(:all) do
      @course_sems = [CourseSemester.make, CourseSemester.make]
      @enrolls_course_sem1 = (1..5).to_a.map { Enrollment.make :course_semester => @course_sems[0] }
      @enrolls_course_sem2 = (1..2).to_a.map { Enrollment.make :course_semester => @course_sems[1] }
    end

    it { Enrollment.course_semesters_in(@course_sems[0]).should == @enrolls_course_sem1 }

    it { Enrollment.course_semesters_in(@course_sems[1]).should == @enrolls_course_sem2 }

    it { Enrollment.course_semesters_in(@course_sems).should == @enrolls_course_sem1.concat(@enrolls_course_sem2) }

  end


  context "calling proposal_for_student" do
    it 'should return an empty array for a student without disciplines' do
      @student = Student.make_unsaved
      @student.curriculum.stub(:school_id).and_return(31)
      @student.curriculum.should_receive(:disciplines).and_return([])
      Enrollment.proposal_for_student(@student).should == []
    end

    #it 'should return an array of Enrollments with the disciplines from the curriculum' do
      #@student = Student.make
      #discipline = Discipline.make
      #discipline.courses.make(:course_school => CourseSchool.make(:school => @student.curriculum.school, :period => @student.curriculum.period)).course_semesters.make(:semester => (Time.now.year*10+((Time.now.month-1)/6+1)))
      #@student.curriculum.implementations.make(:discipline => discipline)
      #Enrollment.proposal_for_student(@student).map { |ep| ep.course_semester.course.discipline }.should == [discipline]
    #end
  end


end
