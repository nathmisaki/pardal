# language: pt
Funcionalidade: Perfil do Usuário
  Eu como usuário do sistema
  Quero criar um perfil para o meu usuário
  Para disponibilizar conteúdo criado por mim.

  Cenário: Adicionar informações pessoais
    Dado que eu seja um usuário logado
    E que eu esteja em "/me"
    Quando eu clicar em "Informações pessoais"
    E preencher "Nelson Minor Haraguchi Junior" para "Nome Completo"
    E preencher "Sou desenvolvedor do sistema que estão usando" para "Sobre mim"
    E apertar em "Atualizar Perfil"
    Então eu deveria ver "Perfil Atualizado com sucesso"
    E deveria ver "Nelson Minor Haraguchi Junior"
    E deveria ver "Sou desenvolvedor do sistema que estão usando"
