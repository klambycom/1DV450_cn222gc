object false

node do
  child @resourceTypes => :data do
    extends "api/resource_types/show"
  end

  node :links do
    attributes self: request.original_url
  end
end
