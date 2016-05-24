json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :book_id, :description
  json.url lesson_url(lesson, format: :json)
end
