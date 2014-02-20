object false

node do
  child @tags => :items do
    extends "api/tags/show"
  end

  node :links do
    attributes self: request.original_url
  end
end
