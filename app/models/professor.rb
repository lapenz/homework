class Professor < ActiveRecord::Base
  self.table_name = "professor"
  self.establish_connection(:athus)


end
