Dado /^que eu não estou autenticado$/ do
  visit(destroy_usuario_session_path)
end

Dado /^que eu tenha um usuário "([^\"]*)" com senha "([^\"]*)"$/ do |email, password|
  u = User.new(:email => email,
           :password => password,
           :password_confirmation => password)
  u.confirm! if u.save!
end

Dado /^que eu seja um usuário logado$/ do
  email = 'testing@man.net'
  password = 'secretpass'

  Dado %{que eu tenha um usuário "#{email}" com senha "#{password}"}
  E %{eu vou para login}
  E %{eu preencho "user_email" com "#{email}"}
  E %{eu preencho "user_password" com "#{password}"}
  E %{eu aperto "user_submit"}

end

Dado /^que eu tenha um registro de ([^\s]+) com os campos:$/ do |modelo, table|
  eval(modelo.to_s.classify).new(table.rows_hash).save!
end

