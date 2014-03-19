object @resource

unless defined?(show_data_for?)
  def show_data_for? value
    true
  end
end

attributes :uuid        if show_data_for? 'uuid'
attributes :name        if show_data_for? 'name'
attributes :url         if show_data_for? 'url'
attributes :description if show_data_for? 'description'
attributes :created_at  if show_data_for? 'created_at'
attributes :updated_at  if show_data_for? 'updated_at'

if show_data_for? 'resource_type'
  child :resource_type do
    attributes :uuid, :name
  end
end

if show_data_for? 'user'
  child :user do
    attributes :uuid, :firstname, :email
  end
end

if show_data_for? 'license'
  child :license do
    attributes :uuid, :name
  end
end

if show_data_for? 'tags'
  child :tags do
    attributes :uuid, :tag
  end
end

node :links do |res|
  attributes author: api_user_url(res.user.uuid),
             author_image: gravatar_url_for(res.user),
             self: api_resource_url(res.uuid)
end
