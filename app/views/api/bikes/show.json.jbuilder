json.extract! @bike, :name, :gender, :num_gears,
                     :hourly_price, :neighborhood, :owner_id

json.image_url_medium image_path(@bike.picture.url(:medium))
json.image_url_thumb image_path(@bike.picture.url(:thumb))


json.owner @bike.owner, :id, :name, :address

json.size @bike.size, :id, :suggested_height, :frame_size

json.category @bike.category, :id, :name

json.extras @bike.extras do |extra|
  json.extract! extra, :id, :name
end
