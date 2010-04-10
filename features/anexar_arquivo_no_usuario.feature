# language: pt
Funcionalidade: Anexar arquivo no usuário
  Eu como usuário do sistema
  Quero poder anexar arquivos a minha conta
  Para disponibiliza-los para download

  Cenário: Anexar arquivo
    Dado que eu seja um usuário logado
    E que eu esteja em "/me"
    Quando eu clicar em "Anexar Arquivo"
    E enviar o arquivo "public/images/rails.png" em "attachment_uploaded_file"
    E apertar em "Enviar Anexo"
    E deveria estar em "/me"
    E deveria ver "rails.png"
