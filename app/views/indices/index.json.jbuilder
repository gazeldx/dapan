json.array!(@indices) do |index|
  json.extract! index, :id, :name, :current_date, :upshot, :closing_price, :opening_price, :advance, :decline
  json.url index_url(index, format: :json)
end
