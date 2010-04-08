# language: pt
Funcionalidade: Visualizar Historico Escolar
  Eu como Aluno
  Quero visualizar as Disciplinas que já cursei bem como o semestre em que foram cursadas e o conceito final
  Para analizar as disciplinas em que eu me matricularei no semestre seguinte
  E constatar a quantidade de disciplinas cursadas.

  Cenário: Mostrar todas as Disciplinas Matriculadas
    Dado que eu seja um usuário logado que tenha um aluno com as disciplinas:
       | course_id | grade |
       | 1         | B     |
       | 2         | B     |
       | 3         | B     |
       | 4         | B     |
       | 5         | A     |
       | 6         | F     |
       | 7         | A     |
       | 8         | F     |
       | 9         | F     |
       | 10        | C     |
       | 11        | C     |
     E que eu esteja em "/me"
     Quando eu clicar em "Historico Escolar"
     Então eu deveria ver uma tabela com:
       | Disciplina | Nome da Disciplina                                              | Ano e Semestre | Conceito | Periodo |
       | 1244       | INTRODUCAO A LOGICA                                             | 20062          | B        | 1       |
       | 1242       | MATEMATICA I                                                    | 20062          | F        | 1       |
       | 6262       | LINGUAGEM E TECNICA DE PROGRAMACAO I                            | 20062          | B        | 1       |
       | 6270       | MICROINFORMATICA                                                | 20062          | A        | 1       |
       | 6361       | SISTEMAS DE COMPUTACAO                                          | 20062          | A        | 1       |
       | 6882       | LINGUAGEM E TECNICAS DE PROGRAMAÇÃO ORIENTADAS A OBJETOS(OPTAT) | 20071          | F        | 1       |
       | 1171       | HUMANIDADES                                                     | 20071          | A        | 2       |
       | 1260       | MATEMATICA II                                                   | 20071          | F        | 2       |
       | 1619       | INGLES PARA INFORMATICA                                         | 20071          | F        | 2       |
       | 6378       | SISTEMAS OPERACIONAIS I                                         | 20071          | C        | 2       |
       | 1260       | MATEMATICA II                                                   | 20072          | C        | 2       |




