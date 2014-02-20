object false

node do
  child @users => :items do
    extends "api/users/show"
  end

  node :links do
    attributes self: request.original_url
  end
end
