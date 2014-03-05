object @resource

attributes :uuid        if defined?(show_data_for?) && show_data_for?('uuid')
attributes :name        if defined?(show_data_for?) && show_data_for?('name')
attributes :url         if defined?(show_data_for?) && show_data_for?('url')
attributes :description if defined?(show_data_for?) && show_data_for?('description')
attributes :created_at  if defined?(show_data_for?) && show_data_for?('created_at')
attributes :updated_at  if defined?(show_data_for?) && show_data_for?('updated_at')

if defined?(show_data_for?) && show_data_for?('resource_type')
  child :resource_type do
    attributes :uuid, :name
  end
end

if defined?(show_data_for?) && show_data_for?('user')
  child :user do
    attributes :uuid, :firstname
  end
end

if defined?(show_data_for?) && show_data_for?('license')
  child :license do
    attributes :uuid, :name
  end
end

if defined?(show_data_for?) && show_data_for?('tags')
  child :tags do
    attributes :uuid, :tag
  end
end

node :links do |res|
  attributes author: api_user_url(res.user.uuid),
             author_image: gravatar_url_for(res.user),
             self: api_resource_url(res.uuid)
end
