object false

node do
  child @tags => :data do
    extends "api/tags/show"
  end

  node :links do
    attributes self: request.original_url
  end
end
