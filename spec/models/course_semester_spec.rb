require 'spec_helper'

describe CourseSemester do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    CourseSemester.create!(@valid_attributes)
  end
end
