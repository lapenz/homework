class Produto < ActiveRecord::Base
  self.table_name = "produto"
  self.establish_connection(:athus)


end
