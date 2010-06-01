
begin
  require 'active_record/railtie' # RAILS 3
rescue LoadError
  require 'tasks/rails'   # RAILS 2.3
  require 'active_record'
end


desc 'Realiza a Integraçao Contínua'
task :cruise do
  RAILS_ENV = ENV['RAILS_ENV'] = 'test' # Without this, it will drop your production database.

  out = ENV['CC_BUILD_ARTIFACTS']
  mkdir_p out unless File.directory? out if out

  p80('#')

  invoke_integration_task('spec', 1)
  invoke_integration_task('spec:rcov', 2)
  mv 'coverage/', "#{out}/rcov" if out
  invoke_integration_task('verify_rcov', 3)


  invoke_integration_task('cucumber', 4)

  p80('#')
  puts
  puts 'Integração Contínua realizada com sucesso!'
  p80('*')
  puts 'Agora é só fazer o git push, o CruiseControl'
  puts 'deverá realizar as tarefas de'
  puts 'integração continua no servidor também.'
end

require 'spec/rake/verify_rcov'
RCov::VerifyTask.new(:verify_rcov) { |t| 
  t.threshold = 60.0
  if ENV["CC_BUILD_ARTIFACTS"]
    t.index_html = File.join(ENV["CC_BUILD_ARTIFACTS"], "rcov", "index.html")
  end
}

def p80(string)
  puts(string * 80)
end

def invoke_integration_task(tarefa, indice)
  p80('-')
  puts("Tarefa de integracao nº #{indice}: #{tarefa}")
  invoke_rake_task tarefa
  p80('-')
end

def invoke_rake_task(task)
  #begin
    #CruiseControl::invoke_rake_task task
  #rescue
    Rake::Task[task].invoke
  #end
end
