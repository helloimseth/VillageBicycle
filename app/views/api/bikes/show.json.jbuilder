json.extract! @bike, :name, :gender, :num_gears,
                     :hourly_price, :neighborhood, :owner_id

json.image_url image_path(@bike.picture.url)

json.owner @bike.owner, :id, :name, :address

json.size @bike.size, :id, :suggested_height, :frame_size

json.category @bike.category, :id, :name

json.extras @bike.extras do |extra|
  json.extract! extra, :id, :name
end
