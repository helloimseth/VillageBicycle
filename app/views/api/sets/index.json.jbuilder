json.sizes @sizes do |size|
  json.extract! size, :id, :size, :suggested_height, :frame_size
end

json.categories @categories do |category|
  json.extract! category, :id, :name
end

json.neighborhoods @neighborhoods do |neighborhood|
  json.extract! neighborhood, :id, :name
end

json.extras @extras do |extra|
  json.extract! extra, :id, :name
end
