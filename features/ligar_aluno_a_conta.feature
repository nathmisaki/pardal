# language: pt
Funcionalidade: Ligar aluno a conta de usuário
  Eu como usuário do sistema autenticado e confirmado
  Para acessar as funcionalidades para aluno
  Quero ligar os meus registros de aluno a minha conta

  Cenário: Preencher dados corretos para linkagem do registro
    Dado que eu seja um usuário logado
    E que eu tenha um registro de aluno com os campos:
       | matricula                  | H10100019            |
       | identidade                 | 1111111111           |
       | nome_da_mae                | MARIA DA SILVA SAURO |
       | identidade_data_de_emissao | 2009-10-20           |
    E que eu esteja na página de usuario_link_aluno
    Quando eu preencher o seguinte:
      | Número de Matrícula           | 10100019   |
      | Identidade                    | 1111111111 |
      | Data de Emissão da Identidade | 20/10/2009 |
      | Iniciais do Nome da Mãe       | MSS        |
    E clicar em "Atribuir Aluno a minha Conta"
    Então eu deveria ver "Aluno atribuído com sucesso!"
    E deveria estar na /painel
    E deveria ver "Matrícula atribuída: H1010019"
