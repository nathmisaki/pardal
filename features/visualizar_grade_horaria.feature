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
    Entao eu deveria ver uma tabela como essa:
    """
    <table>
    <tr>
    <th>Início</th>
    <th>Segunda</th>
    <th colspan="2">Terça</th>
    <th>Quarta</th>
    <th>Quinta</th>
    <th>Sexta</th>
    <th>Sábado</th>
    </tr>

    <tr>
      <th>19h</th>
      <td></td>
      <td rowspan=4>6424<br />APS III</td>
      <td rowspan=4>161</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <th>19h55min</th>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <th>20h50min</th>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <th>21h45min</th>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    </table>
    """




