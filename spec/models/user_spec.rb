require 'spec_helper'

describe User do
  it 'should have role owner and student when linking student' do
    user = User.make
    user.confirm!
    student = Student.make(:mothers_name => "Gloria Maria Fantasico")
    link_student = { :registration => student.registration,
                     :mothers_name_initials => "GMF",
                     :identity => student.identity,
                     :identity_emission_date => student.identity_emission_date.strftime("%d/%m/%Y")}
    user.link_student=(link_student)

    p user.link_student

    user.save.should be_true
    user.has_role?(:owner,student).should be_true
    user.has_role?(:student,student).should be_true
  end
end
