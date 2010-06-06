require 'spec_helper'

describe Proposal do
  it "#logger should return ActiveRecord::Base.logger" do
    Proposal.new.send(:logger).should == ActiveRecord::Base.logger
  end

  it "#enrollments_from_courses should return an Array of Enrollments to fill the Enrollments#new form" do
    stud = Student.make
    cs = course_semester_for_curriculum(stud.curriculum, :semester => Time.now.year_semester)
    course_semester_for_curriculum(stud.curriculum, :semester => 6.months.ago.year_semester, :course => cs.course)

    Proposal.new(stud).send(:enrollments_from_courses, [cs.course]).should == [Enrollment.new(:student => stud, :course_semester => cs)]
  end

  it "#enrollments_from_courses should return an Array with the already enrolled(?) enrollments from the student" do
    stud = Student.make
    cs = course_semester_for_curriculum(stud.curriculum, :semester => Time.now.year_semester)
    course_semester_for_curriculum(stud.curriculum, :semester => 6.months.ago.year_semester, :course => cs.course)
    enroll = enrollment_with_implementation(:student => stud, :course_semester => cs)

    Proposal.new(stud).send(:enrollments_from_courses, [cs.course]).should == [enroll]
  end

  it "#disciplines_with_prerrequisites_concluded should filter disciplines that has pre_requisites and that these aren't concluded" do
    #TODO: implement test
    Proposal.new.send(:disciplines_with_prerrequisites_concluded, []).should == []
  end
end
