object @resource
attributes :uuid, :name, :url, :description, :created_at, :updated_at

child :resource_type do
  attributes :uuid, :name
end

child :user do
  attributes :uuid, :firstname
end

child :license do
  attributes :uuid, :name
end

child :tags do
  attributes :uuid, :tag
end
