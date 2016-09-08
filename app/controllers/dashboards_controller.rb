class DashboardsController < ApplicationController
  before_filter { authorized! if cannot? :read, :dashboard }

  def index
    @books = Book.all
  end

  def lessons
    @book = Book.find(params[:book_id])
    @lessons = Lesson.where(:book_id => params[:book_id])
  end

  def sections
    @lesson = Lesson.find(params[:lesson_id])
    @sections = Section.where(:lesson_id => params[:lesson_id])
  end

  def answer_questions
    @section = Section.find(params[:section_id])
    if SectionsHelper.closed_verify(current_user, @section)
      redirect_to dashboard_path, alert: 'This section it is already done.'
    end
    @questions = @section.questions
  end

  def close_section
    #byebug
    @users_section = UsersSection.new(section_id: params[:section_id], user_id: current_user.id)
    section = Section.find(params[:section_id])
    respond_to do |format|
      if @users_section.save
        # busca o email do professor
        #dados = ProfessorEmails.joins('inner join professor on professor.id = professor_emails.professor_id').joins('inner join turma on turma.professor_id = professor.id').joins('inner join matricula on turma.id = matricula.turma_id').where(:matricula => {aluno_id: current_user.id})
        QuestionMailer.send_questions(section, current_user, "").deliver_now
        format.html { redirect_to result_path(@users_section.section_id), notice: 'Questions was successfully delivered.' }
        format.json { render :show, status: :created, location: @users_section }
      else
        format.html { render :new }
        format.json { render json: @users_section.errors, status: :unprocessable_entity }
      end
    end
  end

  def verify_answer
    question = Question.find(params[:question][:id])

    right = QuestionsHelper.verify_answer(question, params)

    userQuestion = UsersQuestion.find_by(:user_id => current_user.id, :question => question.id) || UsersQuestion.new
    userQuestion.question_id = question.id
    userQuestion.user_id = current_user.id
    userQuestion.right = right
    userQuestion.description = QuestionsHelper.getAnswerDescription(question, params)
    userQuestion.save

    respond_to do |format|
      format.json { render :json => right.to_json }
    end
  end

  def result_questions
    @section = Section.find(params[:section_id])
    @total = UsersQuestion.joins(:question).where(:user_id => current_user.id, :questions => { :section_id => params[:section_id] }).count
    @rights = UsersQuestion.joins(:question).where(:user_id => current_user.id, :right => true, :questions => { :section_id => params[:section_id] }).count
    @wrongs = Question.joins(:users_questions).where(:section_id => params[:section_id], :users_questions => { :user_id => current_user.id, :right => false })
  end

  def result
    total = UsersQuestion.joins(:question).where(:user_id => current_user.id, :questions => { :section_id => params[:section_id] }).count
    rights = UsersQuestion.joins(:question).where(:user_id => current_user.id, :right => true, :questions => { :section_id => params[:section_id] }).count
    wrongs = UsersQuestion.joins(:question).where(:user_id => current_user.id, :right => false, :questions => { :section_id => params[:section_id] }).count

    @rightPercent = rights.to_f / total.to_f * 100.0
    @wrongPercent = wrongs.to_f / total.to_f * 100.0
  end

  private

  def dashboards_params
    params.require(:question).permit(:id, :answers)
  end

end
