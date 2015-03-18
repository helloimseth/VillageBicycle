json.results @search_results.map(&:searchable) do |model|
  json.extract! model, :id, :name
  json.extract! model, :category_id if model.class == Bike
  json.image_url_thumb image_path(model.picture.url(:thumb))
end
