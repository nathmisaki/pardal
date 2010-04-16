require 'spec_helper'

describe Profile do
  before(:each) do
    @valid_attributes = {
      :description => "value for description",
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Profile.create!(@valid_attributes)
  end
end
