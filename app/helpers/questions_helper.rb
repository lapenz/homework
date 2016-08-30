module QuestionsHelper
  def printQuestion(question)
    if !question.description.blank?
      description = String.new(question.description)
      count = description.count "{"

      for i in 1..count do
        replaceWithFields(description)
      end
      description += "<input value=\"#{question.id}\" type=\"hidden\" name=\"question[id]\">"
      description
    end
  end

  def printRightQuestion(question)
    if !question.description.blank?
      description = String.new(question.description)
      count = description.count "{"

      for i in 1..count do
        replaceWithFilledFields(description, true)
      end
      description
    end
  end

  def printWrongQuestion(userQuestion)
    if !userQuestion.description.blank?
      description = String.new(userQuestion.description)
      count = description.count "{"

      for i in 1..count do
        replaceWithFilledFields(description, false)
      end
      description += "<input autocapitalize=\"none\" value=\"#{userQuestion.question_id}\" type=\"hidden\" name=\"question[id]\">"
      description
    end
  end

  def verify_answer(question, params)
    QuestionsHelper.verify_answer(question, params)
  end

  def self.verify_answer(question, params)
    rightDescription = String.new(question.description)

    (getAnswerDescription(question, params) == rightDescription) ? true : false
  end

  def self.getAnswerDescription(question, params)
    description = String.new(question.description)

    params[:question][:answers].each { |answer|
      replaceWithAnswer(answer, description)
    }

    description
  end

  private
  def replaceWithFilledFields(description, disabled)
    disabled = disabled ? 'disabled' : ''
    originalAnswer = getOriginalAnswer(description)
    answerToFill = originalAnswer.gsub(/[{}%&"]/,'') # remove special characters
    description.sub!(originalAnswer, "<input autocapitalize=\"none\" class=\"answer-field\" type=\"text\" value=\"#{answerToFill}\" #{disabled} name=\"question[answers][]\" autocomplete=\"off\" style=\"width: #{((originalAnswer.length + 3) * 6.5)}px;\">")
  end

  def replaceWithFields(description)
    originalAnswer = getOriginalAnswer(description)
    answerSize = originalAnswer.length - 2 # para remover os {} da contagem
    description.sub!(originalAnswer, "<input autocapitalize=\"none\" class=\"answer-field\" type=\"text\" name=\"question[answers][]\" autocomplete=\"off\" maxlength=\"#{answerSize}\" style=\"width: #{((answerSize + 3) * 6.5)}px;\">")
  end

  def self.replaceWithAnswer(answer, description)
    rightAnswer = getOriginalAnswer(description)
    description.sub!(rightAnswer, "{" + answer + "}")
  end

  def getOriginalAnswer(description)
    QuestionsHelper.getOriginalAnswer(description)
  end
  
  def self.getOriginalAnswer(description)
    i = description.index("{")
    j = description.index("}")
    description[i..j]
  end

end
