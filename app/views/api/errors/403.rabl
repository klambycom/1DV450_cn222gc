node(:status) { "403" }
node(:message) { "Only admins can do that." }
node(:developerMessage) { "Only admins are allowed to change licenses and resource types." }

node :links do
  attributes moreInfo: "http://developers.lvh.me:3000/docs/felkoder",
             documentation: "http://developers.lvh.me:3000/docs/kom-igang",
             self: request.original_url
end
