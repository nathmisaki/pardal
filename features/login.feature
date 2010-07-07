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
    Quando eu preencher "Email" com "nelsonmhjr@gmail.com"
    E pressionar "Registrar-se"
    Então "nelsonmhjr@gmail.com" deve receber 1 email
    Quando "nelsonmhjr@gmail.com" abre o email com o texto "Ative sua Conta"
    E eu clico em "Ativar minha conta" no Email
    Então eu devo estar no menu principal
    E devo ver "Sua conta foi confirmada com sucesso. E já logamos com ela para você."
    E eu devo estar logado com o usuário "nelsonmhjr@gmail.com"
    E o usuário "nelsonmhjr@gmail.com" deve estar associado ao aluno "0626805"


