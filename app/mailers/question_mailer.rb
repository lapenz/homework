class QuestionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.question_mailer.send_questions.subject
  #
  def send_questions(section, current_user)

    @section = section
    @total = UsersQuestion.joins(:question).where(:user_id => current_user.id, :questions => { :section_id => section.id }).count
    @rights = UsersQuestion.joins(:question).where(:user_id => current_user.id, :right => true, :questions => { :section_id => section.id }).count
    @wrongs = Question.joins(:users_questions).where(:section_id => section.id, :users_questions => { :user_id => current_user.id, :right => false })

    @current_user = current_user

    #byebug
    if Rails.env.production?
      if current_user.admin?
        mail to:  current_user.email, subject: "#{current_user.name} lesson test"
      else
        # busca o email do professor
        dados = Professor.joins('inner join turma on turma.professor_id = professor.id').joins('inner join matricula on turma.id = matricula.turma_id').where(:matricula => {aluno_id: current_user.id, status: [1,2]})
        mail to:  dados[0].email + ", lucasarthurpenz@gmail.com", subject: "#{current_user.name} lesson"
      end
    else
      mail to: "lucasarthurpenz@gmail.com", subject: "#{current_user.name} lesson test"
    end
  end
end
