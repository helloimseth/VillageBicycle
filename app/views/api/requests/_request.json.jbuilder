json.extract! request, :id, :start, :end, :requestor_id, :bike_id, :approved
json.start request.start.to_formatted_s(:short)
json.end request.end.to_formatted_s(:short)

json.requestor_name request.requestor.name

json.bike_name request.bike.name
json.bike_type request.bike.type

json.bike_owner request.bike.owner.name
json.bike_owner_id request.bike.owner.id

if request.bike.owner.id == current_user.id
  json.image_url_thumb image_path(request.requestor.picture.url(:thumb))
else
  json.image_url_thumb image_path(request.bike.owner.picture.url(:thumb))
end
