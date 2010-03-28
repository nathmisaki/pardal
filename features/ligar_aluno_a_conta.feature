# language: pt
Funcionalidade: Ligar aluno a conta de usuário
  Eu como usuário do sistema autenticado e confirmado
  Para acessar as funcionalidades para aluno
  Quero ligar os meus registros de aluno a minha conta

  Cenário: Preencher dados corretos para linkagem do registro
    Dado que eu seja um usuário logado
    E que eu tenha um registro de student com os campos:
      | registration           | H10100019            |
      | identity               | 1111111111           |
      | mother_name            | MARIA DA SILVA SAURO |
      | identity_emission_date | 2009-10-20           |
    Quando eu vou para página de link_student_users
    Então eu deveria estar na "/users/link_student"
    Então eu deveria ver "Número de Matrícula"
    Quando eu preencher o seguinte:
      | Número de Matrícula           | 10100019   |
      | Identidade                    | 1111111111 |
      | Data de Emissão da Identidade | 20/10/2009 |
      | Iniciais do Nome da Mãe       | MSS        |
    E aperto "Atribuir Aluno a minha Conta"
    Então eu deveria ver "Aluno atribuído com sucesso!"
    E deveria estar na /painel
    E deveria ver "Matrícula atribuída: H1010019"
