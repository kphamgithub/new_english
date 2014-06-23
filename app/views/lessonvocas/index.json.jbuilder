json.array!(@lessonvocas) do |lessonvoca|
  json.extract! lessonvoca, :id, :lesson_id, :vocabulary_id, :name
  json.url lessonvoca_url(lessonvoca, format: :json)
end
