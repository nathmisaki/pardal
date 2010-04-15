# language: pt
Funcionalidade: Perfil do Usuário
  Eu como usuário do sistema
  Quero criar um perfil para o meu usuário
  Para disponibilizar conteúdo criado por mim.

  Contexto:
    Dado que eu seja um usuário logado
    E que eu esteja em "/me"

  Cenário: Visualizar anexos adicionados
    Dado que eu tenha anexado o arquivo "public/images/rails.png"
    Quando eu clicar em "Perfil"
    Então eu deveria ver "rails.png"
