
begin
  require 'active_record/railtie' # RAILS 3
rescue LoadError
  require 'tasks/rails'   # RAILS 2.3
  require 'active_record'
end

require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

TAREFAS_DE_INTEGRACAO = %w(
  spec
  spec:rcov
  verify_rcov
  cucumber:features
)

desc 'Realiza a Integraçao Contínua'
task :cruise do
  p80('*')
  TAREFAS_DE_INTEGRACAO.each_with_index do |tarefa_de_integracao, indice|
    p80('-')
    puts("Tarefa de integracao nº #{indice + 1}: #{tarefa_de_integracao}")
    Rake::Task[tarefa_de_integracao].invoke
    p80('-')
  end
  p80('*')
  puts
  puts 'Integração Contínua realizada com sucesso!'
  p80('*')
  puts 'Agora é só fazer o git push, o CruiseControl'
  puts 'deverá realizar as tarefas de'
  puts 'integração continua no servidor também.'
end

# I don't wanna use Cucumber::Rake ...
#
namespace :cucumber do
  desc 'Executa todas as features do Cucumber'
  task :features do
    sh('cucumber features')
  end  
end

require 'spec/rake/verify_rcov'
RCov::VerifyTask.new(:verify_rcov) { |t| t.threshold = 50.0 }

def p80(string)
  puts(string * 80)
end
