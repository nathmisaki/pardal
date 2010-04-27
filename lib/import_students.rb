class ImportStudents < ImportClass

  def initialize
    @old_table_class = LegacyStudent
    @new_table_class = Student
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      hash[:registration] = reg[:NumeroDeMatricula]
      hash[:name] = reg[:Nome]
      hash[:identity] = reg[:NumeroDoRegistroGeral]
#      hash[:identity_state] = reg[:]
      hash[:identity_emission_organ] = reg[:OrgaoEmissorDoRG]
      hash[:identity_emission_date] = reg[:DataDeEmissaoDoRG]
      hash[:elector_title] = reg[:NumeroDoTituloDeEleitor]
      hash[:electoral_zone] = reg[:NumeroDaZonaEleitoral]
      hash[:military_identification] = reg[:NumeroDoCertificadoMilitar]
      hash[:birth_date] = reg[:DataDeNascimento]
      hash[:gender] = reg[:Sexo]
      hash[:birth_city] = reg[:Naturalidade]
      hash[:birth_state] = reg[:EstadoOndeNasceu]
      hash[:birth_country] = reg[:CodigoDaNacionalidade]
      hash[:fathers_name] = reg[:NomeDoPai]
      hash[:mothers_name] = reg[:NomeDaMae]
#      hash[:address_path] = reg[:]
      hash[:address_streetname] = reg[:Endereco]
#      hash[:address_number] = reg[:]
#      hash[:address_complement] = reg[:]
      hash[:address_neighbourhood] = reg[:Bairro]
      hash[:address_municipality] = reg[:MunicipioDaResidencia]
      hash[:address_state] = reg[:EstadoDeResidencia]
      hash[:address_postal_code] = reg[:CodigoDeEnderecamentoPostal]
      hash[:phone] = reg[:Telefone]
      hash[:high_school_name] = reg[:EstabelecimentoDeSegundoGrau]
      hash[:high_school_municipality] = reg[:SedeDoEstabelecimento]
      hash[:high_school_state] = reg[:EstadoDoEstabelecimento]
      hash[:high_school_conclusion_year] = reg[:AnoDeConclusaoDoSegundoGrau]
      hash[:ingress_form] = reg[:FormaDeIngresso]
      hash[:high_school_type] = reg[:SegundoGrau]
      hash[:education] = reg[:Escolaridade]
      hash[:university] = reg[:Universitario]
      hash[:ingress_exam_date] = reg[:DataDoVestibular]
      hash[:ingress_exam_classification] = reg[:ClassificacaoNoVestibular]
      hash[:ingress_exam_points] = reg[:TotalDePontosNoVestibular].tr(",",".").to_f
      hash[:active] = reg[:Ativo]
      hash[:curriculum_id] = Curriculum.all( :conditions =>
                                            [ "school_id = ?
                                              and period_id = ?
                                              and structure_code = ?",
                                              reg[:CodigoDoCurso].to_i,
                                              reg[:CodigoDoTurno].to_i,
                                              reg[:CodigoDaEstruturaCurricular].to_i]).first
      hash[:curriculum_id] = hash[:curriculum_id].id unless hash[:curriculum_id].nil?
      @rows << hash
    end
    @legacy_rows = nil
  end

end
