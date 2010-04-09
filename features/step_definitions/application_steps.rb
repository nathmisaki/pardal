Dado /^que eu não estou autenticado$/ do
  visit(destroy_usuario_session_path)
end

Dado /^que eu tenha um usuário "([^\"]*)" com senha "([^\"]*)"$/ do |email, password|
  u = User.make(:email => email,
           :password => password,
           :password_confirmation => password)
  u.save!
end

Dado /^que eu seja um usuário logado$/ do
  password = 'secretpass'
  user = User.make(:password => password, :password_confirmation => password)
  user.confirm!
  email = user.email

  Dado %{que eu esteja na página de new_user_session}
  E %{eu preencho "user_email" com "#{email}"}
  E %{eu preencho "user_password" com "#{password}"}
  E %{eu aperto "user_submit"}

end

Dado /^que eu tenha um registro de ([^\s]+) com os campos:$/ do |modelo, table|
  Object.const_get(modelo.to_s.classify).make(table.rows_hash)
end

Dado /^que eu seja um usuário logado que tenha um aluno com o histórico:$/ do |table|
  Dado %{que eu seja um usuário logado}
  user = User.last
  student = Student.make
  user.link_student = { :registration => student.registration,
    :identity => student.identity,
    :identity_emission_date => student.identity_emission_date,
    :mothers_name_initials => student.mothers_name_initials.first
  }
  table.hashes.each do |hash|
    disc = Discipline.make(:code => hash[:discipline_code], :name => hash[:discipline_name])
    course = Course.make(:discipline => disc)
    student.curriculum.implementations.make(:discipline => disc, :school_semester => hash[:school_semester]) if
      student.curriculum.implementations.find(:conditions => { :discipline_id => disc.id }).blank?
    student.enrollments.make(:course => course, :semester => hash[:semester], :grade => hash[:grade])
  end

end
