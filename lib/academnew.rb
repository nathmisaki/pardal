class Academnew < ActiveRecord::Base
  self.establish_connection(
    :adapter => "mysql",
    :encoding => "utf8",
    :reconnect => "false",
    :database => "academnew",
    :pool => "5",
    :username => "root"
  )
end
