
begin
  require 'active_record/railtie' # RAILS 3
rescue LoadError
  require 'tasks/rails'   # RAILS 2.3
  require 'active_record'
end


TAREFAS_DE_INTEGRACAO = %w(
  spec
  spec:rcov
  verify_rcov
  cucumber
)

desc 'Realiza a Integraçao Contínua'
task :cruise do
  RAILS_ENV = ENV['RAILS_ENV'] = 'test' # Without this, it will drop your production database.
  p80('*')
  TAREFAS_DE_INTEGRACAO.each_with_index do |tarefa_de_integracao, indice|
    p80('-')
    puts("Tarefa de integracao nº #{indice + 1}: #{tarefa_de_integracao}")
    invoke_rake_task tarefa_de_integracao
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

require 'spec/rake/verify_rcov'
RCov::VerifyTask.new(:verify_rcov) { |t| t.threshold = 100.0 }

def p80(string)
  puts(string * 80)
end

def invoke_rake_task(task)
  begin
    CruiseControl::invoke_rake_task task
  rescue
    Rake::Task[task].invoke
  end
end
