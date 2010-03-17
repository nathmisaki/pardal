# language: pt
Funcionalidade: Usuário deve poder se increver no site

  Cenário: Acessar tela de registro de usuário
    Dado que eu esteja na página de new_usuario_session
    Quando eu clicar em "Registrar Usuário para acessar o sistema"
    Então eu deveria ver "Email"
    E deveria ver "Senha"
    E deveria ver "Confirmação de Senha"

