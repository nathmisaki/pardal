module Proposals
  class School31 < Proposal
    def calculateEnrollments
      disciplines = student.curriculum.disciplines
      disciplines = disciplines_without_concluded(disciplines)
      #disciplines = disciplines_with_prerrequisites_concluded(disciplines)
      #disciplines = student.n_minus_3(disciplines)

      courses = courses_from_curriculum(disciplines)

      enrollments = enrollments_from_courses(courses)

      #$proposta = $this->filtrarSemestreDoAlunoQuePodeAdiantar($proposta);

  #$proposta = $this->addDadosDisciplinas($proposta);

  #$proposta = $this->filtrarTurmasInativas($proposta);
  #$proposta = $this->filtrarTurmasexclusivasdecalouros($proposta);

  #$proposta = $this->filtrarDisciplinasSemTurma($proposta);
  #$dps = $this->getDependenciasSeriado($proposta);
  #$proposta = $this->adicionarInfoDps($proposta, $dps);


  #$proposta = $this->checarCorequisitos($proposta);



  #$proposta = $this->marcarTurmasQueExcederamLimiteDeAlunos($proposta);
  #sort_assocmultiarray($proposta, 'periodo', SORT_ASC);

  #$proposta = $this->adicionarDisciplinasLiberadasParaAluno($proposta, ano(),semestre());
  #$this->disciplinas = $proposta;
  #$this->dependencias = $dps;

    end
  end
end
