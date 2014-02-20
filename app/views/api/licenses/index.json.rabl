object false

node do
  child @licenses => :data do
    extends "api/licenses/show"
  end

  node :links do
    attributes self: request.original_url
  end
end
