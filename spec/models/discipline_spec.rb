require 'spec_helper'

describe Discipline do
  before(:each) do
    @valid_attributes = {
      :code => 1,
      :name => "value for name",
      :department_id => 1,
      :acronym => "value for acronym",
      :credit_hours => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Discipline.create!(@valid_attributes)
  end
end
