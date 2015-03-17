json.extract! request, :start, :end, :requestor_id, :bike_id
json.requestor_name request.requestor.name
json.bike_name request.bike.name
json.bike_owner request.bike.owner_name
