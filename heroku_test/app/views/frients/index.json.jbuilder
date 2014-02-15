json.array!(@frients) do |frient|
  json.extract! frient, :id, :name, :address
  json.url frient_url(frient, format: :json)
end
