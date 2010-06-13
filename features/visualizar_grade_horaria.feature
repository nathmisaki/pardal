# language: pt
Funcionalidade: Visualizar grade horária curricular
  Eu como usuário do sistema
  Quero visualizar a grade horária no formato mais próximo possível do papel
  Para checar se há alguma coisa errada no banco de dados

  Cenário: Visualizar uma disciplina
    Dado que eu tenha a o currículo disciplina "6424-APS III" com a turma "161", no semestre atual, no horário:
      | weekday | start_hour | end_hour |
      | ter     | 19:00      | 22:40    |
    E que eu estou logado
    Quando eu acesso a página de grade horária do curriculo




