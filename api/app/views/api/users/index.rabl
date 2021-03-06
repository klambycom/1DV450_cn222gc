object @user
attributes :uuid, :firstname, :lastname, :email, :created_at, :updated_at, :admin

node :links do |user|
  attributes self: api_user_url(user.uuid)
end
