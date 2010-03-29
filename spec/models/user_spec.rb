require 'spec_helper'

describe User do

  context "linking student" do
    before(:all) do
      @user = User.make :email => "teste@teste.com"
      @user.confirm!
      @student = Student.make(:mothers_name => "Gloria Maria Fantasico")
      @link_student = { :registration => @student.registration,
        :mothers_name_initials => "GMF",
        :identity => @student.identity,
        :identity_emission_date => @student.identity_emission_date.strftime("%d/%m/%Y")}
    end

    it 'should have role owner and student when linking student' do
      @user.link_student = @link_student

      @user.save.should be_true
      @user.has_role?(:owner, @student).should be_true
      @user.has_role?(:student, @student).should be_true
    end

    it 'should have errors when no registration is provided' do
      @user.link_student = @link_student.merge(:registration => '')

      @user.save.should be_false
      @user.errors.size.should > 0
    end

    it 'should have errors when registration is not find' do
      @user.link_student = @link_student.merge(:registration => 'G0000000')

      @user.save.should be_false
      @user.errors.size.should > 0
    end
  end
end
