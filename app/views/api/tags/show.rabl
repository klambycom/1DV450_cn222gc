object @tag
attributes :uuid, :tag

node :links do |tag|
  attributes self: api_tag_url(tag.uuid)
end
