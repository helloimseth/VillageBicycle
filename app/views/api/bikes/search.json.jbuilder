json.array! @bikes do |bike|
  json.extract! bike, :id, :name, :gender, :hourly_price, :num_gears,
                      :category_id, :owner_id, :owner_name, :size_id

  json.extract! bike.owner, :latitude, :longitude

  json.image_url_thumb image_path(bike.picture.url(:thumb))
end
