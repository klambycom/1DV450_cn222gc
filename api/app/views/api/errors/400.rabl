node(:status) { "400" }
node(:message) { "Incorrect data." }
node(:developerMessage) { "Incorrect data." }
node(:errors) { @errors }

node :links do
  attributes moreInfo: "http://developers.lvh.me:3000/docs/felkoder",
             documentation: "http://developers.lvh.me:3000/docs/kom-igang",
             self: request.original_url
end
