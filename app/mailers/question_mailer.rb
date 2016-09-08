class QuestionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.question_mailer.send_questions.subject
  #
  def send_questions(section, current_user, email_dest)

    @total = UsersQuestion.joins(:question).where(:user_id => current_user.id, :questions => { :section_id => section.id }).count
    @rights = UsersQuestion.joins(:question).where(:user_id => current_user.id, :right => true, :questions => { :section_id => section.id }).count
    @wrongs = Question.joins(:users_questions).where(:section_id => section.id, :users_questions => { :user_id => current_user.id, :right => false })

    @current_user = current_user

    #byebug

    mail to: email_dest + ", lucasarthurpenz@gmail.com", subject: "#{current_user.name} lesson"
  end
end
