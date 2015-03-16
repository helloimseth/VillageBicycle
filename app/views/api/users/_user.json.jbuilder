json.extract! user, :id, :name, :address, :bio
json.neighborhood user.neighborhood.name
json.image_url_medium image_path(user.picture.url(:medium))
json.image_url_thumb image_path(user.picture.url(:thumb))
