require 'spec_helper'

describe Student do

  context "find_by_registration" do
    before(:all) do
      @student = Student.first(:conditions => { :registration => "F0626805" }) || Student.make(:registration => "F0626805")
    end

    it 'should return with the number and initial letter' do
      Student.find_by_registration('F0626805').should == @student
    end

    it 'should return witi only number' do
      Student.find_by_registration('0626805').should == @student
    end

  end

end
