require 'spec_helper'

describe Enrollment do

  describe "#course_semester_in Named Scope" do
    before(:all) do
      @course_sems = [CourseSemester.make, CourseSemester.make]
      @enrolls_course_sem1 = (1..5).to_a.map { Enrollment.make :course_semester => @course_sems[0] }
      @enrolls_course_sem2 = (1..2).to_a.map { Enrollment.make :course_semester => @course_sems[1] }
    end
    after(:all) { DatabaseCleaner.clean }

    it 'should accept a CourseSemester as param' do
      Enrollment.course_semesters_in(@course_sems[0]).should == @enrolls_course_sem1
    end

    it 'should accept an Array of CourseSemesters' do
      Enrollment.course_semesters_in(@course_sems).should == Enrollment.all(:conditions => { :course_semester_id => @course_sems })
    end

    it 'should accept an Array of Integers(IDs)' do
      array = @course_sems.map(&:id)
      Enrollment.course_semesters_in(array).should == Enrollment.all(:conditions => { :course_semester_id => array })
    end
  end

  it '#semester_eql Named Scope should accept a semester as param' do
    course_sem = CourseSemester.make(:semester => 20101)
    enrolls_sem1 = (1..5).to_a.map { Enrollment.make :course_semester => course_sem }
    Enrollment.semester_eql(20101).should == enrolls_sem1
  end

  it '#student_eql Named Scope should accept a student_id as param' do
    student = Student.make
    enrolls_stud1 = (1..5).to_a.map { Enrollment.make :student => student }
    Enrollment.student_eql(student.id).should == enrolls_stud1
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
