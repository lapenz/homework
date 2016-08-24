class QuestionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.question_mailer.send_questions.subject
  #
  def send_questions(section, current_user)

    @rights = UsersQuestion.joins(:question).where(:user_id => current_user.id, :right => true, :questions => { :section_id => section.id }).count
    @wrongs = Question.joins(:users_questions).where(:section_id => section.id, :users_questions => { :user_id => current_user.id, :right => false })

    @current_user = current_user
#byebug

    select * from matricula
    join turma t on t.id = matricula.turma_id
    join curso c on c.id = t.curso_id
    join professor_emails e on e.professor_id = t.professor_id
    where matricula.aluno_id = 3046 and c.idioma_id = 1

    mail to: "lucasarthurpenz@gmail.com", subject: "#{current_user.name} lesson"
  end
end
