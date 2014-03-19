object false

node do
  child @licenses => :items do
    extends "api/licenses/show"
  end

  node :links do
    attributes self: request.original_url
  end
end
