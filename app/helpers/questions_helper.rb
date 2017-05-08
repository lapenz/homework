module QuestionsHelper
  def printQuestion(question)
    if !question.description.blank?
      description = String.new(question.description)
      count = description.count "{"
      if count > 0 # if there're answers on question
        for i in 1..count do
          replaceWithFields(description)
        end
      else
        createFieldWithoutAnswer(description)
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
    rightDescription = normalize_answer(rightDescription)
    answerDescription = normalize_answer(getAnswerDescription(question, params))
    (answerDescription.casecmp(rightDescription) == 0) ? true : false # compare ignoring case
  end

  def self.getAnswerDescription(question, params)
    description = String.new(question.description)

    replaceWithAnswer(params, description)

    description
  end

  private
  def normalize_answer(answer)
    QuestionsHelper.normalize_answer(answer)
  end

  def self.normalize_answer(answer)
    answer.gsub!('’', '') # Apostrophe Character U+2019
    answer.gsub!("'", '') # Apostrophe Character U+0027
    I18n.transliterate(answer) # Remove accents
  end

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
    if (description.count("{") > 0) # if there're answers on question
      params[:question][:answers].each do |answer|
        i = getOpenKeyPosition(description, i+1)
        j = getCloseKeyPosition(description, j+1)

        lengthDif = 0
        answer.strip! # Remove whitespace
        lengthDif = description[i..j].length - 2 - answer.length unless answer.length > description[i..j].length # if param its smaller than right answer get the length diff to fill blank
        description.sub!(description[i..j], "{" + answer + (' ' * lengthDif) + "}")
      end
    else
      description = params[:question][:answers][0]
    end


  end

  def createFieldWithoutAnswer(description)
    description << "<input autocapitalize=\"none\" value=\"#{description}\" class=\"answer-field\" type=\"hidden\" name=\"question[answers][]\" >"
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

      " <input type=\"submit\" value=\"Send\" class=\"btn btn-success btn-sm\"/>"

  end

end
