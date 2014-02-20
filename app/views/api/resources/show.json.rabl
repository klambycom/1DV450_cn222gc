object @resource

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
    attributes :uuid, :firstname
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
