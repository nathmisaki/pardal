require 'spec_helper'

describe Course do
  context "with #current_course_semester" do
    before(:each) do
      @course = Course.make
      @course_semester = CourseSemester.make(:course => @course, :semester => Time.now.year_semester)
      4.times { CourseSemester.make(:course => @course, :semester => 1.year.ago.year_semester) }
    end

    it { @course.current_course_semester.should eql(@course_semester) }
  end
end
