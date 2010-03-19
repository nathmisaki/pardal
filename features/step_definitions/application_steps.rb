Dado /^que eu não estou autenticado$/ do
  visit(destroy_usuario_session_path)
end

Dado /^que eu tenha um usuário "([^\"]*)" com senha "([^\"]*)" e login "([^\"]*)"$/ do |email, password, login|
  User.new(:email => email,
           :login => login,
           :password => password,
           :password_confirmation => password).save!
end

Dado /^que eu seja um usuário logado$/ do
  email = 'testing@man.net'
  login = 'Testing man'
  password = 'secretpass'

  Dado %{que eu tenha um usuário "#{email}" com senha "#{password}" e login "#{login}"}
  E %{eu vou para login}
  E %{eu preencho "user_email" com "#{email}"}
  E %{eu preencho "user_password" com "#{password}"}
  E %{eu pressiono em "usuario_submit"}
end

Dado /^que eu tenha um registro de ([^\s]+) com os campos:$/ do |modelo, table|
  
end

