json.array!(@event_dates) do |event_date|
  json.extract! event_date, :id, :date, :event_id, :comment
  json.url event_date_url(event_date, format: :json)
end
