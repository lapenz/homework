module QuestionsHelper
  def printQuestion(question)
    if !question.description.blank?
      description = String.new(question.description)
      count = description.count "{"

      for i in 1..count do
        replaceWithFields(description)
      end
      description += "<input value=\"#{question.id}\" type=\"hidden\" name=\"question[id]\">"
      description += printSendButton(count)
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
      description += printSendButton(count)
      description
    end
  end

  def verify_answer(question, params)
    QuestionsHelper.verify_answer(question, params)
  end

  def self.verify_answer(question, params)
    rightDescription = String.new(question.description)
    rightDescription = I18n.transliterate(rightDescription) # Remove accents
    answerDescription = I18n.transliterate(getAnswerDescription(question, params)) # Remove accents
    (answerDescription.casecmp(rightDescription) == 0) ? true : false # compare ignoring case
  end

  def self.getAnswerDescription(question, params)
    description = String.new(question.description)

    replaceWithAnswer(params, description)

    description
  end

  private
  def replaceWithFilledFields(description, disabled)
    disabled = disabled ? 'disabled' : ''
    originalAnswer = getFirstOccurrenceAnswer(description)
    answerToFill = originalAnswer.gsub(/[{}%&"]/,'') # remove special characters
    description.sub!(originalAnswer, "<input autocapitalize=\"none\" class=\"answer-field\" type=\"text\" value=\"#{answerToFill}\" #{disabled} name=\"question[answers][]\" autocomplete=\"off\" style=\"width: #{((originalAnswer.length + 3) * 6.5)}px;\">")
  end

  def replaceWithFields(description)
    originalAnswer = getFirstOccurrenceAnswer(description)
    answerSize = originalAnswer.length - 2 # para remover os {} da contagem
    description.sub!(originalAnswer, "<input autocapitalize=\"none\" class=\"answer-field\" type=\"text\" name=\"question[answers][]\" autocomplete=\"off\" maxlength=\"#{answerSize}\" style=\"width: #{((answerSize + 3) * 6.5)}px;\">")
  end

  def self.replaceWithAnswer(params, description)
    i = -1
    j = -1

    params[:question][:answers].each { |answer|
      i = getOpenKeyPosition(description, i+1)
      j = getCloseKeyPosition(description, j+1)

      description.sub!(description[i..j], "{" + answer + "}")
    }

  end

  def getFirstOccurrenceAnswer(description)
    QuestionsHelper.getFirstOccurrenceAnswer(description)
  end

  def self.getFirstOccurrenceAnswer(description)
    i = getOpenKeyPosition(description)
    j = getCloseKeyPosition(description)
    description[i..j]
  end

  def getOpenKeyPosition(description, offset = 0)
    QuestionsHelper.getOpenKeyPosition(description, offset)
  end

  def self.getOpenKeyPosition(description, offset = 0)
    description.index("{", offset)
  end

  def getCloseKeyPosition(description, offset = 0)
    QuestionsHelper.getCloseKeyPosition(description, offset)
  end

  def self.getCloseKeyPosition(description, offset = 0)
    description.index("}", offset)
  end

  def printSendButton(answerQty)
    if answerQty > 0
      " <input type=\"submit\" value=\"Send\" class=\"btn btn-success btn-sm\"/>"
    else
      ""
    end
  end

end
