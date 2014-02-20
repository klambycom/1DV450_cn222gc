object false

node do
  child @resources => :data do
    extends "api/resources/show"
  end

  node :links do
    attributes self: request.original_url
  end
end
