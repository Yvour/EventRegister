json.array!(@events) do |event|
  json.extract! event, :id, :name, :initial_date, :comment, :last_date, :user_id, :event_type_id
  json.url event_url(event, format: :json)
end
