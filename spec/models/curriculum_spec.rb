require 'spec_helper'

describe Curriculum do
  before(:each) do
    @valid_attributes = {
      :school_id => 1,
      :period_id => 1,
      :curriculum_type => 1,
      :implementation_semester => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Curriculum.create!(@valid_attributes)
  end
end
