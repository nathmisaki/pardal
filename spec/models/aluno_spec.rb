require 'spec_helper'

describe Aluno do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Aluno.create!(@valid_attributes)
  end
end
