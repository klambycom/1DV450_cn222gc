object @resourceType
attributes :uuid, :name

node :links do |res|
  attributes self: api_resource_type_url(res.uuid)
end
