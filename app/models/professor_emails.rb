class ProfessorEmails < ActiveRecord::Base
  self.table_name = "professor_emails"
  self.establish_connection(:athus)


end
