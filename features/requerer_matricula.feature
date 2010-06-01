# language: pt
Funcionalidade: Requerer Matrícula
  Eu como Aluno da Fatec-SP
  Quero requerer as disciplinas
  Para cursá-las no semestre seguinte

  Contexto:
    Dado que eu seja o usuário "nelson@fatecsp.br" com senha "nelson", autenticado
    E que eu tenha um registro de School com os campos:
      | id   | 31                     |
      | name | Processamento de Dados |
    E que eu tenha um registro de Curriculum com os campos:
      | id        | 990 |
      | school_id | 31  |
    E que eu tenha um registro de Student com os campos:
      | registration  | F0626805                      |
      | name          | Nelson Minor Haraguchi Junior |
      | id            | 9990                          |
      | curriculum_id | 990                           |
    E que o usuário "nelson@fatecsp.br" seja o aluno "F0626805"
    E que eu esteja em "/me"
    E que o aluno "F0626805" tenha as disciplinas, com turmas de seu curso:
      | name                                  | acronym | code |
      | Matemática I                          | MAT I   | 1    |
      | Linguagem e Técnicas de Programação I | LTP I   | 2    |
      | Humanidades                           | HUM     | 3    |
      | Português                             | PORT    | 4    |
    E que a disciplina "1" tenha uma turma do curriculo do aluno "F0626805" aberta neste semestre com as aulas:
      | weekday | start_hour | end_hour |
      | 4       | 19:00      | 22:30    |
    E que a disciplina "2" tenha uma turma do curriculo do aluno "F0626805" aberta neste semestre com as aulas:
      | weekday | start_hour | end_hour |
      | 2       | 19:00      | 22:30    |
    E que a disciplina "3" tenha uma turma do curriculo do aluno "F0626805" aberta neste semestre com as aulas:
      | weekday | start_hour | end_hour |
      | 2       | 19:00      | 22:30    |
    E que a disciplina "4" tenha uma turma do curriculo do aluno "F0626805" aberta neste semestre com as aulas:
      | weekday | start_hour | end_hour |
      | 3       | 19:00      | 22:30    |

  Cenário: Mostrar turmas de um aluno novo
    Quando eu clicar em "Rematrícula" dentro de "#student_9990"
    Então eu deveria ver "MAT I"
    E deveria ver "LTP I"

  Cenário: Mostrar turmas de um aluno que já concluiu algumas disciplinas
    Dado que o aluno "F0626805" tenha concluído as disciplinas "1,2"
    Quando eu clicar em "Rematrícula" dentro de "#student_9990"
    Então eu não deveria ver "MAT I"
    E não deveria ver "LTP I"
    Mas deveria ver "HUM"
    E deveria ver "PORT"
