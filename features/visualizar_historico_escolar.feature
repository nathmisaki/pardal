# language: pt
Funcionalidade: Visualizar Historico Escolar
  Eu como Aluno
  Quero visualizar as Disciplinas que já cursei bem como o semestre em que foram cursadas e o conceito final
  Para analizar as disciplinas em que eu me matricularei no semestre seguinte
  E constatar a quantidade de disciplinas cursadas.

  Cenário: Mostrar todas as Disciplinas Matriculadas
    Dado que eu seja um usuário logado que tenha um aluno com o histórico:
       | discipline_code | discipline_name                                                 | grade | semester | school_semester |
       | 1244            | INTRODUCAO A LOGICA                                             | B     | 20062    | 1               |
       | 1242            | MATEMATICA I                                                    | F     | 20062    | 1               |
       | 6262            | LINGUAGEM E TECNICA DE PROGRAMACAO I                            | B     | 20062    | 1               |
       | 6270            | MICROINFORMATICA                                                | A     | 20062    | 1               |
       | 6361            | SISTEMAS DE COMPUTACAO                                          | A     | 20062    | 1               |
       | 6882            | LINGUAGEM E TECNICAS DE PROGRAMAÇÃO ORIENTADAS A OBJETOS(OPTAT) | F     | 20071    | 1               |
       | 1171            | HUMANIDADES                                                     | A     | 20071    | 2               |
       | 1260            | MATEMATICA II                                                   | F     | 20071    | 2               |
       | 1619            | INGLES PARA INFORMATICA                                         | F     | 20071    | 2               |
       | 6378            | SISTEMAS OPERACIONAIS I                                         | C     | 20071    | 2               |
       | 1260            | MATEMATICA II                                                   | C     | 20072    | 2               |
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




