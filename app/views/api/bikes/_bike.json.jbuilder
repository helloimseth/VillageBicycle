json.extract! bike, :name, :gender, :num_gears, :notes,
                    :hourly_price, :neighborhood, :owner_id,
                    :size_id, :type, :extras, :extra_ids

json.image_url_medium image_path(@bike.picture.url(:medium))
json.image_url_thumb image_path(@bike.picture.url(:thumb))
