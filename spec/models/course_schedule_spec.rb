require 'spec_helper'

describe CourseSchedule do
  before(:each) do
    @valid_attributes = {
      :course_semester_id => 1,
      :weekday => 1,
      :start_hour => Time.now,
      :end_hour => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    CourseSchedule.create!(@valid_attributes)
  end
end
