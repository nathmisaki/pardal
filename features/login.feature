# language: pt
Funcionalidade: Usuário deve poder se increver no site

  Cenário: Acessar tela de registro de usuário
    Dado que eu esteja na página de new_user_session
    Quando eu clicar em "Registrar Usuário para acessar o sistema"
    Então eu deveria ver "Registro de usuário"

  Cenário: Deve poder logar-se com o número de matrícula e credenciais antigas
    Dado que eu tenha cadastrado na base sandb.users o usuário "0626805" com a senha "123bananinha"
    E que eu esteja na página de login
    Quando eu preencher "Usuário" com "0626805"
    E preencher "Senha" com "123bananinha"
    Então eu devo ver um formulário de novo usuário


