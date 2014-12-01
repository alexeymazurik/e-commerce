json.array!(@supplies) do |supply|
  json.extract! supply, :id, :title, :description, :price
  json.url supply_url(supply, format: :json)
end
