require 'spec_helper'

describe CurrentUsersHelper do
  it 'should return a unordered list with all student_registrations owned by' do
    user = User.make
    student = Student.make
    link_student = { :registration => student.registration,
      :mothers_name_initials => student.mothers_name_initials.first,
      :identity => student.identity,
      :identity_emission_date => student.identity_emission_date.strftime("%d/%m/%Y")}
    user.link_student = link_student
    user.save
    helper.students_owned(user).should match(/<ul.*>.*<li.*>.*#{ student.registration }<\/li><\/ul>/)
  end
end
