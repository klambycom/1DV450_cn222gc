object @user
attributes :uuid, :firstname, :lastname, :created_at, :updated_at

node :links do |user|
  attributes self: api_user_url(user.uuid)
end
