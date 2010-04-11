require 'spec_helper'

describe Implementation do
  before(:each) do
    @valid_attributes = {
      :curriculum_id => 1,
      :discipline_id => 1,
      :school_semester => 1,
      :discipline_type_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Implementation.create!(@valid_attributes)
  end
end
