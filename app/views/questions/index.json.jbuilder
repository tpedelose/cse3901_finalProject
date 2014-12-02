json.array!(@questions) do |question|
  json.extract! question, :id, :content, :correct, :fakes, :tag, :category, :times_used, :times_correct
  json.url question_url(question, format: :json)
end
