object false

node do
  child @resourceTypes => :items do
    extends "api/resource_types/show"
  end

  node :links do
    attributes self: request.original_url
  end
end
