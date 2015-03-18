json.extract! bike, :id, :name, :gender, :num_gears, :notes,
                    :hourly_price, :owner_id, :size_id, :category_id,
                    :extra_ids, :owner_name, :size_id

json.extract! bike.owner, :address, :latitude, :longitude, :neighborhood_id

json.image_url_medium image_path(bike.picture.url(:medium))
json.image_url_thumb image_path(bike.picture.url(:thumb))
