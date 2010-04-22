require 'spec_helper'

describe User do

  context "with attach_student!" do
    before(:each) do
      @user = User.make
      @student = Student.make
      @user.attach_student!(@student)
    end
    
    subject { @user }

    it { should be_has_role(:student) }

    it { should be_has_role(:owner) }

    it { @user.objects_with_role(:student, Student, true).should == [ @student ] }
    it { @user.objects_with_role(:owner, Student, true).should == [ @student ] }
  end

  context "objects_with_role" do
    before(:each) do
      @user = User.make
      @user.attach_student!(Student.make)
    end    
  
  end
  context "linking student" do
    before(:each) do
      @user = User.make :email => "teste@teste.com"
      @user.confirm!
      @student = Student.make(:mothers_name => "Gloria Maria Fantasico")
      @link_student = { :registration => @student.registration,
        :mothers_name_initials => "GMF",
        :identity => @student.identity,
        :identity_emission_date => @student.identity_emission_date.strftime("%d/%m/%Y")}
    end

    context "with link_student_*" do
      before(:each) do
        @user.link_student=@link_student
      end
      context "registration" do
        it { @user.link_student_registration.should == @link_student[:registration] }
        it {
          @user.link_student_registration = "H1010101"
          @user.link_student[:registration].should == "H1010101"
        }
      end
      context "identity" do
        it { @user.link_student_identity.should == @link_student[:identity] }
        it {
          @user.link_student_identity = 'ASDF'
          @user.link_student[:identity].should == 'ASDF'
        }
      end
      context "identity_emission_date" do
        it { @user.link_student_identity_emission_date.should == @link_student[:identity_emission_date] }
        it {
          @user.link_student_identity_emission_date = '27/06/1986'
          @user.link_student[:identity_emission_date].should == '27/06/1986'
        }
      end
      context "mothers_name_initials" do
        it { @user.link_student_mothers_name_initials.should == @link_student[:mothers_name_initials] }
        it {
          @user.link_student_mothers_name_initials = 'ADF'
          @user.link_student[:mothers_name_initials].should == 'ADF'
        }
      end
    end

    it 'should have role owner and student when linking student' do
      @user.link_student = @link_student

      @user.save.should be_true
      @user.has_role?(:owner, @student).should be_true
      @user.has_role?(:student, @student).should be_true
    end

    it 'should have invalid error on :link_student_registration when no registration is provided' do
      @user.link_student = @link_student.merge(:registration => '')

      @user.valid?
      @user.errors.on(:link_student_registration).should include(I18n.t(:invalid, :scope => 'activerecord.errors.messages'))
    end

    it 'should have not_find error on :link_student_registration when no registration is find' do
      @user.link_student = @link_student.merge(:registration => 'G0000000')

      @user.valid?
      @user.errors.on(:link_student_registration).should include(I18n.t(:not_find, :scope => 'activerecord.errors.messages'))
    end

    it 'should have taken error on :link_student_registration when student already has an owner' do
      user2 = User.make :email => "teste2@teste.com"
      user2.confirm!
      user2.link_student = @link_student
      user2.save

      @user.link_student = @link_student
      @user.valid?
      @user.errors.on(:link_student_registration).should include(I18n.t(:taken, :scope => 'activerecord.errors.messages'))
    end

    it 'should have not_match error on :link_student_identity when identity is wrong' do
      @user.link_student = @link_student.merge(:identity => "0X000000X")

      @user.valid?
      @user.errors.on(:link_student_identity).should include(I18n.t(:not_match, :scope => 'activerecord.errors.messages'))
    end

    it 'should have not_match error on :link_student_identity_emission_date when it is wrong' do
      @user.link_student = @link_student.merge(:identity_emission_date => "01/01/2001")

      @user.valid?
      @user.errors.on(:link_student_identity_emission_date).should include(I18n.t(:not_match, :scope => 'activerecord.errors.messages'))
    end

    it 'should have invalid error on :link_student_identity_emission_date when it not exist' do
      @user.link_student = @link_student.merge(:identity_emission_date => "30/02/2001")

      @user.valid?
      @user.errors.on(:link_student_identity_emission_date).should include(I18n.t(:invalid, :scope => 'activerecord.errors.messages'))
    end

    it 'should have not_match error on :link_student_mothers_name_initials when is wrong' do
      @user.link_student = @link_student.merge(:mothers_name_initials => "AAAYOUWIN")

      @user.valid?
      @user.errors.on(:link_student_mothers_name_initials).should include(I18n.t(:not_match, :scope => 'activerecord.errors.messages'))
    end
  end
end
