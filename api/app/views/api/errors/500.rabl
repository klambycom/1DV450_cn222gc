node(:status) { "500" }
node(:message) { "A temporary error occurred. Try again later." }
node(:developerMessage) { "A error occurred on the server." }

node :links do
  attributes moreInfo: "http://developers.lvh.me:3000/docs/felkoder",
             documentation: "http://developers.lvh.me:3000/docs/kom-igang",
             self: request.original_url
end
