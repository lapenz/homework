require 'test_helper'

class QuestionMailerTest < ActionMailer::TestCase
  test "send_questions" do
    mail = QuestionMailer.send_questions
    assert_equal "Send questions", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
