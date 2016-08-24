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
        QuestionMailer.send_questions(section, current_user).deliver_now
        format.html { redirect_to dashboard_path, notice: 'Questions was successfully delivered.' }
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

  private

  def dashboards_params
    params.require(:question).permit(:id, :answers)
  end

end
