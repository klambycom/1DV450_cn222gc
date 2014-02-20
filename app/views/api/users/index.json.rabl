object false

node do
  child @users => :data do
    extends "api/users/show"
  end

  node :links do
    attributes self: request.original_url
  end
end
