object @resource
attributes :id, :name, :url, :description, :created_at, :updated_at

child :resource_type do
  attributes :id, :name
end

child :user do
  attributes :id, :firstname
end

child :license do
  attributes :id, :name
end

child :tags do
  attributes :id, :tag
end
