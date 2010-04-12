require 'spec_helper'

describe EnrollmentSituation do
  before(:each) do
    @valid_attributes = {
      :description => "value for description",
      :valid => false
    }
  end

  it "should create a new instance given valid attributes" do
    EnrollmentSituation.create!(@valid_attributes)
  end
end
