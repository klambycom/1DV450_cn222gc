The Open Education Resource Handler
===================================

Kom igång med utveckling
------------------------

### lvh.me

Jag använder subdomäner, använd därför lvh.me.

### Api

Skapa databas `rake db:migrate`.

Lägg till data i databasen `rake db:seed`.

Starta applikationen `rails s`.

Besök `http://developers.lvh.me:3000/docs/kom-igang`.

Skapa en applikation med `http://lvh.me:3001/auth/toerh_doorkeeper/callback`
som redirect uri.

### Klient

Ändra applikations id och secret:
`export APPLICATION_ID="ÄNDRA HÄR"`
`export APPLICATION_SECRET="ÄNDRA HÄR"`

Eller ändra i filen `client/config/initializers/omniauth.rb`.

Uppdatera client/app/assets/javascript/config.js:

AuthorizationProvider.setApplicationId(ÄNDRA HÄR);

Starta applikationen `rails s -p 3001`.

### Ändringar i API:et

Det gick inte att lägga till taggar när man skapade resurser innan, men det går
nu.

Skickar med lite mer information om resurser och användare.

CORS

Information om resultatet. Limit, offset och antal poster.

Flyttat kod från controller till model.
