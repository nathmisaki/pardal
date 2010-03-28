require 'spec_helper'

describe Student do

  context "find_by_registration" do
    before(:all) do
      @student = Student.first(:conditions => { :registration => "F0626805" }) || Student.make(:registration => "F0626805")
    end

    it 'should return with the number and initial letter' do
      Student.find_by_registration('F0626805').should == @student
    end

    it 'should return with only number' do
      Student.find_by_registration('0626805').should == @student
    end

  end

  context "registration_with_initial_letter" do
    it 'should return with A for registrations that begin with 701 until 992' do
      (70..99).each do |year|
        (1..2).each do |sem|
          number = "#{year}#{sem}".rjust(3,'0')
          Student.registration_with_initial_letter(number).should == "A#{number}"
        end
      end
    end

    it 'should return with F for registrations that begin with 001 until 072' do
      (0..7).each do |year|
        (1..2).each do |sem|
          number = "#{year}#{sem}".rjust(3,'0')
          Student.registration_with_initial_letter(number).should == "F#{number}"
        end
      end
    end

    it 'should return with H for registrations that begin with 081 until 692' do
      (8..69).each do |year|
        (1..2).each do |sem|
          number = "#{year}#{sem}".rjust(3,'0')
          Student.registration_with_initial_letter(number).should == "H#{number}"
        end
      end
    end
  end

  context 'registration_check_number' do
    it 'should 5 for 062680' do
      Student.registration_check_number('062680').should == 5
    end

    it 'should 8 for 071658' do
      Student.registration_check_number('071658').should == 8
    end

    it 'should 2 for 1010989' do
      Student.registration_check_number('1010989').should == 2
    end
  end

  context "valid mothers name initials" do
    before(:all) do
      @student = Student.make(:mothers_name => "Maria Da Silva Sauro Sant'Anna")
    end

    it 'should return true for MSSS' do
      student.valid_mothers_name_initials?('MSSS').should be_true
    end

  end
end
