json.array! @bikes do |bike|
  json.extract! bike, :id, :name, :gender, :hourly_price,
                      :owner_id, :owner_name, :size_id, :type, :neighborhood

  json.image_url_thumb image_path(bike.picture.url(:thumb))
end
