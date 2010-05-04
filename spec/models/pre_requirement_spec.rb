require 'spec_helper'

describe PreRequirement do
  before(:each) do
    @valid_attributes = {
      :implementation_id => 1,
      :pre_requirement_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    PreRequirement.create!(@valid_attributes)
  end
end
