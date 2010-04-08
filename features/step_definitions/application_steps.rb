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

Dado /^que eu seja um usuário logado que tenha um aluno com as disciplinas:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
  Dado %{que eu seja um usuário logado}
  user = User.last
end
