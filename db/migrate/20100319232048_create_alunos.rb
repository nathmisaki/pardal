class CreateAlunos < ActiveRecord::Migration
  def self.up
    create_table :alunos do |t|
      t.string     :matricula,                                    :limit => 10
      t.string     :nome,                                         :limit => 100
      t.string     :identidade,                                   :limit => 20
      t.date       :identidade_data_de_emissao
      t.string     :titulo_de_eleitor,                            :limit => 15
      t.string     :zona_eleitorar,                               :limit => 5
      t.date       :nascimento
      t.string     :sexo,                                         :limit => 1
      t.string     :municipio_de_nascimento,                      :limit => 50
      t.string     :estado_de_nascimento,                         :limit => 2
      t.string     :pais_de_nascimento,                           :limit => 3
      t.string     :nome_do_pai,                                  :limit => 100
      t.string     :nome_da_mae,                                  :limit => 100
      t.string     :tipo_logradouro,                              :limit => 20
      t.string     :logradouro,                                   :limit => 50
      t.string     :bairro,                                       :limit => 30
      t.string     :municipio_de_residencia,                      :limit => 50
      t.string     :estado_de_residencia,                         :limit => 2
      t.string     :cep_de_residencia,                            :limit => 8
      t.string     :telefone,                                     :limit => 15
      t.string     :estabelecimento_de_ensino_medio,              :limit => 50
      t.string     :municipio_do_estabelecimento_de_ensino_medio, :limit => 50
      t.string     :estado_do_estabelecimento_de_ensino_medio,    :limit => 2
      t.string     :ano_de_conclusao_do_ensino_medio,             :limit => 4
      t.string     :forma_de_ingresso,                            :limit => 1
      t.string     :tipo_de_ensino_medio,                         :limit => 1
      t.string     :escolaridade,                                 :limit => 1
      t.string     :universitario,                                :limit => 1
      t.date       :data_do_vestibular
      t.integer    :classificacao_no_vestibular
      t.float      :total_de_pontos_no_vestibular
      t.belongs_to :curso
      t.belongs_to :turno
      t.belongs_to :estrutura

      t.timestamps

      t.index :matricula
      t.index :nome
    end
  end

  def self.down
    drop_table :alunos
  end
end
