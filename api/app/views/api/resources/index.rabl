object false

node do
  child @resources => :items do
    extends "api/resources/show"
  end

  node :links do
    attributes self: request.original_url
  end
end
