Dado /^que eu não estou autenticado$/ do
  visit(destroy_usuario_session_path)
end

Dado /^que eu tenha um usuário "([^\"]*)" com senha "([^\"]*)"$/ do |email, password|
  u = User.make(:email => email,
           :password => password,
           :password_confirmation => password)
  u.save!
end

Dado /^que o usuário "([^\"]*)" esteja confirmado$/ do |user|
  u = User.find_by_email(user)
  u.confirm!
end

Dado /^que eu autentique com o usuário "([^\"]*)" e senha "([^\"]*)"$/ do |user, pass|
  Dado %{que eu esteja na página de new_user_session}
  E %{eu preencho "user_email" com "#{user}"}
  E %{eu preencho "user_password" com "#{pass}"}
  E %{eu aperto "user_submit"}
end

Dado /^que eu seja um usuário logado$/ do
  password = 'secretpass'
  email = 'nononono@nononono.com'
  Dado %{que eu tenha um usuário "#{email}" com senha "#{password}"}
  Dado %{que o usuário "#{email}" esteja confirmado}
  Dado %{que eu autentique com o usuário "#{email}" e senha "#{password}"}
end

Dado /^que eu tenha um registro de ([^\s]+) com os campos:$/ do |modelo, table|
  Object.const_get(modelo.to_s.classify).make(table.rows_hash)
end

Dado /^que eu seja um usuário logado que tenha um aluno com o histórico:$/ do |table|
  Dado %{que eu seja um usuário logado}
  user = User.last
  student = Student.make
  user.attach_student!(student)
  table.hashes.each do |hash|
    disc = Discipline.make(:code => hash[:discipline_code], :name => hash[:discipline_name])
    student.curriculum.implementations.make(:discipline => disc, :school_semester => hash[:school_semester]) if
      student.curriculum.implementations.all(:conditions => { :discipline_id => disc.id }).blank?
    course_school = CourseSchool.make(:school => student.curriculum.school)
    course = Course.make(:discipline => disc, :course_school => course_school, :semester => hash[:semester])
    student.enrollments.make(:course => course, :grade => hash[:grade])
  end

end

Dado /^que eu seja o usuário "([^\"]*)" com senha "([^\"]*)", autenticado$/ do |user, pass|
  Dado %{que eu tenha um usuário "#{user}" com senha "#{pass}"}
  Dado %{que o usuário "#{user}" esteja confirmado}
  Dado %{que eu autentique com o usuário "#{user}" e senha "#{pass}"}
end

Dado /^que o usuário "([^\"]*)" seja o aluno "([^\"]*)"$/ do |user, student_registration|
  user = User.find_by_email(user)
  user.attach_student!(Student.find_by_registration(student_registration))
end

Então /^eu deveria ter um arquivo "([^\"]*)" no modelo Attachment e ele deveria pertencer ao usuário logado$/ do |file_name|
  attach = Attachment.find_all_by_file_name(file_name).last
  attach.should_not be_blank
  attach.attachable.should == User.last
end
