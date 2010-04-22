# language: pt
Funcionalidade: Requerer Matrícula
  Eu como Aluno da Fatec-SP
  Quero requerer as disciplinas
  Para cursá-las no semestre seguinte

  Contexto:
    Dado que eu seja o usuário "nelson@fatecsp.br" com senha "nelson", autenticado
    E que eu tenha um registro de Student com os campos:
      | registration | F0626805                      |
      | name         | Nelson Minor Haraguchi Junior |
      | id           | 9990                          |
    E que o usuário "nelson@fatecsp.br" seja o aluno "F0626805"
    E que eu esteja em "/me"
    Quando eu clicar em "Rematrícula" dentro de "#student_9990"

  Cenário: Não selecionar turma
    Quando eu apertar "Matricular-se nesta disciplina e turma"
    Então eu deveria ver "Turma não pode ser vazio"

