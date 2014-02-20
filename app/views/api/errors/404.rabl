node(:status) { "404" }
node(:message) { "Oops! It looks like that url does not exists." }
node(:developerMessage) { "The resource '#{request.original_url}' does not exist." }

node :links do
  attributes moreInfo: "http://developers.lvh.me:3000/docs/felkoder",
             documentation: "http://developers.lvh.me:3000/docs/kom-igang",
             self: request.original_url
end
