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
      | curriculum   | { :id => 89, :school_id => 31, :period_id => 3 } |
    E que o usuário "nelson@fatecsp.br" seja o aluno "F0626805"
    E que eu tenha registros de "Discipline", associados ao curriculo "89":
      | code | id   | name                                  | acronym   |
      | 6361 | 6361 | Sistemas Computacionais               | SIST COMP |
      | 1252 | 1252 | Matematica 1                          | MAT 1     |
      | 1244 | 1244 | Introdução à Lógica                   | INT LOG   |
      | 6270 | 6270 | Microinformatica                      | MICRO     |
      | 6262 | 6262 | Linguagem e Técnicas de Programação 1 | LTP 1     |
      | 1260 | 1260 | Matematica 2                          | MAT 2     |
      | 1171 | 1171 | Humanidades                           | HUM       |
    E que eu tenha registros de "Course", ligados ao course_school "{ :school_id => 31, :period_id => 3 }":
      | discipline_id | semester | start_dt | end_dt |
      | 6361 | 
    E que o aluno "F0626805" tenha as turmas:

    E que eu esteja em "/me"
    Quando eu clicar em "Rematrícula" dentro de "#student_9990"

  Cenário: Não selecionar turma
    Quando eu apertar "Matricular-se nesta disciplina e turma"
    Então eu deveria ver "Turma não pode ser vazio"

