object @license
attributes :uuid, :name, :description, :url, :updated_at

node :links do |license|
  attributes self: api_license_url(license.uuid)
end
