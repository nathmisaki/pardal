# language: pt
Funcionalidade: Requerer Matrícula
  Eu como Aluno da Fatec-SP
  Quero requerer as disciplinas
  Para cursá-las no semestre seguinte

  Contexto:
    Dado que eu seja o usuário "nelson@fatecsp.br" com senha "nelson", autenticado
    E que eu tenha um registro de Student com os campos:
      | registration  | F0626805                      |
      | name          | Nelson Minor Haraguchi Junior |
      | id            | 9990                          |
    E que o usuário "nelson@fatecsp.br" seja o aluno "F0626805"
    E que eu esteja em "/me"

  Cenário: Mostrar turmas de um aluno novo
    Dado que o aluno "F0626805" tenha as disciplinas, com turmas de seu curso:
      | name                                  | acronym |
      | Matemática I                          | MAT I   |
      | Linguagem e Técnicas de Programação I | LTP I   |
    Quando eu clicar em "Rematrícula" dentro de "#student_9990"
    Então eu deveria ver "MAT I"
    E deveria ver "LTP I"

