class Aluno < ActiveRecord::Base
  self.table_name = "aluno"
  self.establish_connection(:athus)


end
