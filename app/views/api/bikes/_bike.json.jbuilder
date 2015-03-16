json.extract! bike, :id, :name, :gender, :num_gears, :notes,
                    :hourly_price, :neighborhood, :owner_id,
                    :size_id, :type, :extras, :extra_ids, :owner_name

json.extract! bike.owner, :address

json.image_url_medium image_path(bike.picture.url(:medium))
json.image_url_thumb image_path(bike.picture.url(:thumb))
