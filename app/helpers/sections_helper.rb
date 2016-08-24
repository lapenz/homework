module SectionsHelper
  def verify_answer(question, params)
    SectionsHelper.closed_verify(question, params)
  end

  def self.closed_verify(user, section)
    users_sections = UsersSection.find_by(user_id: user.id, section_id: section.id)
    if users_sections.nil?
      return false
    end
    return true
  end
end
