json.array!(@sections) do |section|
  json.extract! section, :id, :lesson_id, :description, :audio
  json.url section_url(section, format: :json)
end
