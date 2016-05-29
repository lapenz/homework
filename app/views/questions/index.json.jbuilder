json.array!(@questions) do |question|
  json.extract! question, :id, :section_id, :description, :intro
  json.url question_url(question, format: :json)
end
