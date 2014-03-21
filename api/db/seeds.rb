# ruby encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(firstname: "Admin",
            lastname: "Test",
            email: "admin@test.com",
            password: "hemligt",
            password_confirmation: "hemligt",
            admin: true)

member = User.create(firstname: "Member",
                     lastname: "Test",
                     email: "member@test.com",
                     password: "hemligt",
                     password_confirmation: "hemligt")

rockTag = Tag.create(tag: "Rock")
psychedelicTag = Tag.create(tag: "Psykedelisk")
Tag.create(tag: "77-punk")
Tag.create(tag: "Hardcore")
Tag.create(tag: "Trallpunk")
h1 = Tag.create(tag: "Funktionell programmering")
h2 = Tag.create(tag: "Haskell")
h3 = Tag.create(tag: "Programmering")

videoResourceType = ResourceType.create(name: "Video")

youtubeLicense = License.create(
  name: "Standardlicens för YouTube",
  url: "http://www.youtube.com/", 
  description:
%q(Vet inte så mycket om licensen.))

mitLicense = License.create(
  name: "MIT",
  url: "http://en.wikipedia.org/wiki/MIT_License", 
  description:
%q(Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.))

resource = Resource.create(name: "White Rabbit",
                           url: "http://www.youtube.com/watch?v=WANNqr-vcx0",
                           description: "Jefferson Airplane - White Rabbit")

resource.resource_type = videoResourceType
resource.license = mitLicense
resource.user = member

resource.tags << rockTag
resource.tags << psychedelicTag

resource.save

haskell = Resource.create(name: "Programming - Why Haskell is Great - 10 minutes",
                          url: "https://www.youtube.com/watch?v=RqvCNb7fKsg",
                          description: "Väldigt rolig och intressant video.")

haskell.resource_type = videoResourceType
haskell.license = youtubeLicense
haskell.user = member

haskell.tags << h1
haskell.tags << h2
haskell.tags << h3

haskell.save

#################
# Documentation #
#################

Doc.create title: 'Kom igång', method: :no_method, content: %q(
Access Token
------------------
För att få tag på din access token måste du skapa en ny applikation med callback url `urn:ietf:wg:oauth:2.0:oob`. Installera sedan oauth2, `gem install oauth2`. Starta irb med `irb -r oauth2`.

Skriv sedan följande kod:

```
callback = "urn:ietf:wg:oauth:2.0:oob"
app_id = "APPLIKATIONENS ID"
secret = "APPLIKATIONENS SECRET"
client = OAuth2::Client.new(app_id, secret, site: "http://lvh.me:3000/")
client.auth_code.authorize_url(redirect_uri: callback)
```

Du får nu en adress som du kan skriva in i din webbläsare för att få tillbaka en "authorization code". Forstätt sen med:

```
access = client.auth_code.get_token('AUTHORIZATION CODE', redirect_uri: callback)
access.token
```

Du får nu en "access token" som du kan använda i t.ex. Postman för att testa API:et.

Postman
-----------
Jag rekommenderar att du använder [Postman](http://www.getpostman.com/) för att testa API:et. Börja med att importera den collection som jag har skapat, URL:en är `https://www.getpostman.com/collections/c197f47a5d3ea3f20189`.

![Importera collection i Postman](http://lvh.me:3000/assets/postmanimport.png)

För att kunna API:et behöver du "access\_token" och "application\_id", och jag rekomenderar därför att du sparar dem i ett environment.

![Environments](http://lvh.me:3000/assets/environment.png)
)
Doc.create title: 'Felkoder', method: :no_method, content: %q(
200
----
Allt har gått bra, se det är ju ingen felkod.

400
-----
Datan som har postats är fel. Felen finns i arrayen errors.

#### Exempel:

```
{
    "status": "400",
    "message": "Incorrect data.",
    "developerMessage": "Incorrect data.",
    "errors": {
        "name": [
            "can't be blank"
        ],
        "url": [
            "can't be blank"
        ],
        "description": [
            "can't be blank"
        ]
    },
    "links": {
        "moreInfo": "http://developers.lvh.me:3000/docs/felkoder",
        "documentation": "http://developers.lvh.me:3000/docs/kom-igang",
        "self": "http://api.lvh.me:3000/resources"
    }
}
```

401
----
För att använda get på alla API:er förutom user, måste du använda API nyckel. För alla andra API:er måste du använda OAuth.

#### Exempel:

```
{
    "status": "401",
    "message": "The application is not authorized",
    "developerMessage": "The application have to be authorized for 'http://api.lvh.me:3000/tags'.",
    "links": {
        "moreInfo": "http://developers.lvh.me:3000/docs/felkoder",
        "documentation": "http://developers.lvh.me:3000/docs/kom-igang",
        "self": "http://api.lvh.me:3000/tags"
    }
}
```

403
---
Användaren måste vara admin för att skapa, uppdatera och ta bort licenser och resurs typer.

```
{
    "status": "403",
    "message": "Only admins can do that.",
    "developerMessage": "Only admins are allowed to change licenses and resource types.",
    "links": {
        "moreInfo": "http://developers.lvh.me:3000/docs/felkoder",
        "documentation": "http://developers.lvh.me:3000/docs/kom-igang",
        "self": "http://api.lvh.me:3000/resource_types"
    }
}
```

404
-----
Resursen du försökte hitta finns inte. Kontrollera att id är rätt.

#### Exempel:

```
{
    "status": "404",
    "message": "Oops! It looks like that url does not exists.",
    "developerMessage": "The resource 'http://api.lvh.me:3000/tags/52434' does not exist.",
    "links": {
        "moreInfo": "http://developers.lvh.me:3000/docs/felkoder",
        "documentation": "http://developers.lvh.me:3000/docs/kom-igang",
        "self": "http://api.lvh.me:3000/tags/52434"
    }
}
```

500
----
Något har gått fel som antagligen inte är ditt fel.

#### Exempel:

```
{
    "status": "500",
    "message": "A temporary error occurred. Try again later.",
    "developerMessage": "A error occurred on the server.",
    "links": {
        "moreInfo": "http://developers.lvh.me:3000/docs/felkoder",
        "documentation": "http://developers.lvh.me:3000/docs/kom-igang",
        "self": "http://api.lvh.me:3000/resources"
    }
}
```
)
Doc.create title: 'Changelog', method: :no_method, content: %q(
20 feb 2014
---------------
Första versionen av API:et är färdigt.
)

Doc.create title: 'Licenses', method: :get, content: %q(
För att använda get måste du skicka med API nycket, `Authorization: Token token={{application_id}}`.

### Url parametrar
* offset, vilken post som resultatet ska börja på.
* limit, antalet poster.

### Format
* json
* xml

### Exempelsvar
```
{
    "links": {
        "self": "http://api.lvh.me:3000/licenses"
    },
    "items": [
        {
            "uuid": "1d9d82cc-8275-4317-9bde-9436839a0d35",
            "name": "MIT",
            "description": "Permission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the \"Software\"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in\nall copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\nTHE SOFTWARE.",
            "url": "http://en.wikipedia.org/wiki/MIT_License",
            "updated_at": "2014-02-20T13:42:17.651Z",
            "links": {
                "self": "http://api.lvh.me:3000/licenses/1d9d82cc-8275-4317-9bde-9436839a0d35"
            }
        },
        ...
    ]
}
```
)
Doc.create title: 'Licenses/:id', method: :get, content: %q(
För att använda get måste du skicka med API nycket, `Authorization: Token token={{application_id}}`.

### Format
* json
* xml

### Exempelsvar
```
{
    "uuid": "fadb4c72-b82c-4e92-8a11-9b5b2e04d440",
    "name": "mit",
    "description": "Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.",
    "url": "http://opensource.org/licenses/MIT",
    "updated_at": "2014-02-20T19:05:56.682Z",
    "links": {
        "self": "http://api.lvh.me:3000/licenses/fadb4c72-b82c-4e92-8a11-9b5b2e04d440"
    }
}
```
)
Doc.create title: 'Licenses', method: :post, content: %q(
För att använda post måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

Användaren måste vara admin.

### Format
* json
* xml

### Data
* name, max 255 tecken.
* description
* url, max 255 tecken.

### Exempelsvar
```
{
    "uuid": "fadb4c72-b82c-4e92-8a11-9b5b2e04d440",
    "name": "MIT",
    "description": "Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.",
    "url": "http://opensource.org/licenses/MIT",
    "updated_at": "2014-02-20T19:05:56.682Z",
    "links": {
        "self": "http://api.lvh.me:3000/licenses/fadb4c72-b82c-4e92-8a11-9b5b2e04d440"
    }
}
```
)
Doc.create title: 'Licenses/:id', method: :put, content: %q(
För att använda put måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

Användaren måste vara admin.

### Format
* json
* xml

### Data
* name, max 255 tecken.
* description
* url, max 255 tecken.

### Exempelsvar
```
{
    "uuid": "fadb4c72-b82c-4e92-8a11-9b5b2e04d440",
    "name": "mit",
    "description": "Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.",
    "url": "http://opensource.org/licenses/MIT",
    "updated_at": "2014-02-20T19:05:56.682Z",
    "links": {
        "self": "http://api.lvh.me:3000/licenses/fadb4c72-b82c-4e92-8a11-9b5b2e04d440"
    }
}
```
)
Doc.create title: 'Licenses/:id', method: :delete, content: %q(
För att använda delete måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

Användaren måste vara admin.

### Format
* json
* xml

### Exempelsvar
```
{
    "uuid": "fadb4c72-b82c-4e92-8a11-9b5b2e04d440",
    "name": "mit",
    "description": "Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.",
    "url": "http://opensource.org/licenses/MIT",
    "updated_at": "2014-02-20T19:05:56.682Z",
    "links": {
        "self": "http://api.lvh.me:3000/licenses/fadb4c72-b82c-4e92-8a11-9b5b2e04d440"
    }
}
```
)

Doc.create title: 'ResourceTypes', method: :get, content: %q(
För att använda get måste du skicka med API nycket, `Authorization: Token token={{application_id}}`.

### Url parametrar
* offset, vilken post som resultatet ska börja på.
* limit, antalet poster.

### Format
* json
* xml

### Exempelsvar
```
{
    "links": {
        "self": "http://api.lvh.me:3000/resource_types"
    },
    "items": [
        {
            "uuid": "37412f35-1284-49cf-a3d7-3652a1fd9575",
            "name": "Video",
            "links": {
                "self": "http://api.lvh.me:3000/resource_types/37412f35-1284-49cf-a3d7-3652a1fd9575"
            }
        },
        ...
    ]
}
```
)
Doc.create title: 'ResourceTypes/:id', method: :get, content: %q(
För att använda get måste du skicka med API nycket, `Authorization: Token token={{application_id}}`.

### Format
* json
* xml

### Exempelsvar
```
{
    "uuid": "37412f35-1284-49cf-a3d7-3652a1fd9575",
    "name": "Video",
    "links": {
        "self": "http://api.lvh.me:3000/resource_types/37412f35-1284-49cf-a3d7-3652a1fd9575"
    }
}
```
)
Doc.create title: 'ResourceTypes', method: :post, content: %q(
För att använda post måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

Användaren måste vara admin.

### Format
* json
* xml

### Data
* name, max 50 tecken.

### Exempelsvar
```
{
    "uuid": "37412f35-1284-49cf-a3d7-3652a1fd9575",
    "name": "Video",
    "links": {
        "self": "http://api.lvh.me:3000/resource_types/37412f35-1284-49cf-a3d7-3652a1fd9575"
    }
}
```
)
Doc.create title: 'ResourceTypes/:id', method: :put, content: %q(
För att använda put måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

Användaren måste vara admin.

### Format
* json
* xml

### Data
* name, max 50 tecken.

### Exempelsvar
```
{
    "uuid": "37412f35-1284-49cf-a3d7-3652a1fd9575",
    "name": "Video",
    "links": {
        "self": "http://api.lvh.me:3000/resource_types/37412f35-1284-49cf-a3d7-3652a1fd9575"
    }
}
```
)
Doc.create title: 'ResourceTypes/:id', method: :delete, content: %q(
För att använda delete måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

Användaren måste vara admin.

### Format
* json
* xml

### Exempelsvar
```
{
    "uuid": "37412f35-1284-49cf-a3d7-3652a1fd9575",
    "name": "Video",
    "links": {
        "self": "http://api.lvh.me:3000/resource_types/37412f35-1284-49cf-a3d7-3652a1fd9575"
    }
}
```
)

Doc.create title: 'Resources', method: :get, content: %q(
För att använda get måste du skicka med API nycket, `Authorization: Token token={{application_id}}`.

### Url parametrar
* offset, vilken post som resultatet ska börja på.
* limit, antalet poster.
* only, vilka fält som ska skickas med i svaret.
* query
* category, kategori uuid.
* license, licens uuid.
* tag, tagg uuid.

### Format
* json
* xml

### Exempelsvar
```
{
    "links": {
        "self": "http://api.lvh.me:3000/resources"
    },
    "items": [
        {
            "uuid": "58b036f4-7b98-4eda-80f9-45f26a5365e6",
            "name": "White Rabbit",
            "url": "http://www.youtube.com/watch?v=WANNqr-vcx0",
            "description": "Jefferson Airplane - White Rabbit",
            "created_at": "2014-02-20T13:42:17.669Z",
            "updated_at": "2014-02-20T13:42:17.694Z",
            "links": {
                "author": "http://api.lvh.me:3000/users/cb30fcce-505b-49fa-8a36-14d7cd251f0e",
                "author_image": "https://secure.gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee",
                "self": "http://api.lvh.me:3000/resources/58b036f4-7b98-4eda-80f9-45f26a5365e6"
            },
            "resource_type": {
                "uuid": "37412f35-1284-49cf-a3d7-3652a1fd9575",
                "name": "Video"
            },
            "user": {
                "uuid": "cb30fcce-505b-49fa-8a36-14d7cd251f0e",
                "firstname": "John"
            },
            "license": {
                "uuid": "1d9d82cc-8275-4317-9bde-9436839a0d35",
                "name": "MIT"
            },
            "tags": [
                {
                    "uuid": "b8918231-c9c4-458f-af86-0b62df368c4f",
                    "tag": "Rock"
                },
                {
                    "uuid": "decfa2af-2cc9-4d33-bf72-1af2425aa23f",
                    "tag": "Psykedelisk"
                }
            ]
        },
        ...
    ]
}
```
)
Doc.create title: 'Resources/:id', method: :get, content: %q(
För att använda get måste du skicka med API nycket, `Authorization: Token token={{application_id}}`.

### Url parametrar
* only, vilka fält som ska skickas med i svaret.

### Format
* json
* xml

### Exempelsvar
```
{
    "uuid": "58b036f4-7b98-4eda-80f9-45f26a5365e6",
    "name": "White Rabbit",
    "url": "http://www.youtube.com/watch?v=WANNqr-vcx0",
    "description": "Jefferson Airplane - White Rabbit",
    "created_at": "2014-02-20T13:42:17.669Z",
    "updated_at": "2014-02-20T13:42:17.694Z",
    "links": {
        "author": "http://api.lvh.me:3000/users/cb30fcce-505b-49fa-8a36-14d7cd251f0e",
        "author_image": "https://secure.gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee",
        "self": "http://api.lvh.me:3000/resources/58b036f4-7b98-4eda-80f9-45f26a5365e6"
    },
    "resource_type": {
        "uuid": "37412f35-1284-49cf-a3d7-3652a1fd9575",
        "name": "Video"
    },
    "user": {
        "uuid": "cb30fcce-505b-49fa-8a36-14d7cd251f0e",
        "firstname": "John"
    },
    "license": {
        "uuid": "1d9d82cc-8275-4317-9bde-9436839a0d35",
        "name": "MIT"
    },
    "tags": [
        {
            "uuid": "b8918231-c9c4-458f-af86-0b62df368c4f",
            "tag": "Rock"
        },
        {
            "uuid": "decfa2af-2cc9-4d33-bf72-1af2425aa23f",
            "tag": "Psykedelisk"
        }
    ]
}
```
)
Doc.create title: 'Resources', method: :post, content: %q(
För att använda post måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

### Format
* json
* xml

### Data
* name, max 255 tecken.
* url, max 255 tecken.
* description, max 255 tecken.
* resource_type_id
* license_id

### Exempelsvar
```
{
    "uuid": "58b036f4-7b98-4eda-80f9-45f26a5365e6",
    "name": "White Rabbit",
    "url": "http://www.youtube.com/watch?v=WANNqr-vcx0",
    "description": "Jefferson Airplane - White Rabbit",
    "created_at": "2014-02-20T13:42:17.669Z",
    "updated_at": "2014-02-20T13:42:17.694Z",
    "links": {
        "author": "http://api.lvh.me:3000/users/cb30fcce-505b-49fa-8a36-14d7cd251f0e",
        "author_image": "https://secure.gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee",
        "self": "http://api.lvh.me:3000/resources/58b036f4-7b98-4eda-80f9-45f26a5365e6"
    },
    "resource_type": {
        "uuid": "37412f35-1284-49cf-a3d7-3652a1fd9575",
        "name": "Video"
    },
    "user": {
        "uuid": "cb30fcce-505b-49fa-8a36-14d7cd251f0e",
        "firstname": "John"
    },
    "license": {
        "uuid": "1d9d82cc-8275-4317-9bde-9436839a0d35",
        "name": "MIT"
    },
    "tags": [
        {
            "uuid": "b8918231-c9c4-458f-af86-0b62df368c4f",
            "tag": "Rock"
        },
        {
            "uuid": "decfa2af-2cc9-4d33-bf72-1af2425aa23f",
            "tag": "Psykedelisk"
        }
    ]
}
```
)
Doc.create title: 'Resources/:id', method: :put, content: %q(
För att använda put måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

### Format
* json
* xml

### Data
* name, max 255 tecken.
* url, max 255 tecken.
* description, max 255 tecken.
* resource_type_id
* license_id
* user_id

### Exempelsvar
```
{
    "uuid": "58b036f4-7b98-4eda-80f9-45f26a5365e6",
    "name": "White Rabbit",
    "url": "http://www.youtube.com/watch?v=WANNqr-vcx0",
    "description": "Jefferson Airplane - White Rabbit",
    "created_at": "2014-02-20T13:42:17.669Z",
    "updated_at": "2014-02-20T13:42:17.694Z",
    "links": {
        "author": "http://api.lvh.me:3000/users/cb30fcce-505b-49fa-8a36-14d7cd251f0e",
        "author_image": "https://secure.gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee",
        "self": "http://api.lvh.me:3000/resources/58b036f4-7b98-4eda-80f9-45f26a5365e6"
    },
    "resource_type": {
        "uuid": "37412f35-1284-49cf-a3d7-3652a1fd9575",
        "name": "Video"
    },
    "user": {
        "uuid": "cb30fcce-505b-49fa-8a36-14d7cd251f0e",
        "firstname": "John"
    },
    "license": {
        "uuid": "1d9d82cc-8275-4317-9bde-9436839a0d35",
        "name": "MIT"
    },
    "tags": [
        {
            "uuid": "b8918231-c9c4-458f-af86-0b62df368c4f",
            "tag": "Rock"
        },
        {
            "uuid": "decfa2af-2cc9-4d33-bf72-1af2425aa23f",
            "tag": "Psykedelisk"
        }
    ]
}
```
)
Doc.create title: 'Resources/:id', method: :delete, content: %q(
För att använda delete måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

### Format
* json
* xml

### Exempelsvar
```
{
    "uuid": "58b036f4-7b98-4eda-80f9-45f26a5365e6",
    "name": "White Rabbit",
    "url": "http://www.youtube.com/watch?v=WANNqr-vcx0",
    "description": "Jefferson Airplane - White Rabbit",
    "created_at": "2014-02-20T13:42:17.669Z",
    "updated_at": "2014-02-20T13:42:17.694Z",
    "links": {
        "author": "http://api.lvh.me:3000/users/cb30fcce-505b-49fa-8a36-14d7cd251f0e",
        "author_image": "https://secure.gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee",
        "self": "http://api.lvh.me:3000/resources/58b036f4-7b98-4eda-80f9-45f26a5365e6"
    },
    "resource_type": {
        "uuid": "37412f35-1284-49cf-a3d7-3652a1fd9575",
        "name": "Video"
    },
    "user": {
        "uuid": "cb30fcce-505b-49fa-8a36-14d7cd251f0e",
        "firstname": "John"
    },
    "license": {
        "uuid": "1d9d82cc-8275-4317-9bde-9436839a0d35",
        "name": "MIT"
    },
    "tags": [
        {
            "uuid": "b8918231-c9c4-458f-af86-0b62df368c4f",
            "tag": "Rock"
        },
        {
            "uuid": "decfa2af-2cc9-4d33-bf72-1af2425aa23f",
            "tag": "Psykedelisk"
        }
    ]
}
```
)

Doc.create title: 'Tags', method: :get, content: %q(
För att använda get måste du skicka med API nycket, `Authorization: Token token={{application_id}}`.

### Url parametrar
* offset, vilken post som resultatet ska börja på.
* limit, antalet poster.

### Format
* json
* xml

### Exempelsvar
```
{
    "links": {
        "self": "http://api.lvh.me:3000/tags"
    },
    "items": [
        {
            "uuid": "b8918231-c9c4-458f-af86-0b62df368c4f",
            "tag": "Rock",
            "links": {
                "self": "http://api.lvh.me:3000/tags/b8918231-c9c4-458f-af86-0b62df368c4f"
            }
        },
        ...
    ]
}
```
)
Doc.create title: 'Tags/:id', method: :get, content: %q(
För att använda get måste du skicka med API nycket, `Authorization: Token token={{application_id}}`.

### Format
* json
* xml

### Exempelsvar
```
{
    "uuid": "b8918231-c9c4-458f-af86-0b62df368c4f",
    "tag": "Rock",
    "links": {
        "self": "http://api.lvh.me:3000/tags/b8918231-c9c4-458f-af86-0b62df368c4f"
    }
}
```
)
Doc.create title: 'Tags', method: :post, content: %q(
För att använda post måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

### Format
* json
* xml

### Data
* tag, max 50 tecken.

### Exempelsvar
```
{
    "uuid": "b8918231-c9c4-458f-af86-0b62df368c4f",
    "tag": "Rock",
    "links": {
        "self": "http://api.lvh.me:3000/tags/b8918231-c9c4-458f-af86-0b62df368c4f"
    }
}
```
)
Doc.create title: 'Tags/:id', method: :put, content: %q(
För att använda put måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

### Format
* json
* xml

### Data
* tag, max 50 tecken.

### Exempelsvar
```
{
    "uuid": "b8918231-c9c4-458f-af86-0b62df368c4f",
    "tag": "Rock",
    "links": {
        "self": "http://api.lvh.me:3000/tags/b8918231-c9c4-458f-af86-0b62df368c4f"
    }
}
```
)
Doc.create title: 'Tags/:id', method: :delete, content: %q(
För att använda delete måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

### Format
* json
* xml

### Exempelsvar
```
{
    "uuid": "b8918231-c9c4-458f-af86-0b62df368c4f",
    "tag": "Rock",
    "links": {
        "self": "http://api.lvh.me:3000/tags/b8918231-c9c4-458f-af86-0b62df368c4f"
    }
}
```
)

Doc.create title: 'Users', method: :get, content: %q(
För att se inloggad användare måste du autentiseria med OAuth, `Authorization: Bearer={{access_token}}`.

### Format
* json
* xml

### Exempelsvar
```
{
    "uuid": "fe1f7857-1612-49c6-8131-f4a93c9fdd62",
    "firstname": "Christian",
    "lastname": "Nilsson",
    "email": "christian@klamby.com",
    "created_at": "2014-02-20T13:43:36.825Z",
    "updated_at": "2014-02-20T13:44:48.659Z",
    "links": {
        "self": "http://api.lvh.me:3000/users/fe1f7857-1612-49c6-8131-f4a93c9fdd62"
    }
}
```
)
Doc.create title: 'Users/:id', method: :get, content: %q(
För att se en användare måste du skicka med API nycket, `Authorization: Token token={{application_id}}`.

### Format
* json
* xml

### Exempelsvar
```
{
    "uuid": "fe1f7857-1612-49c6-8131-f4a93c9fdd62",
    "firstname": "Christian",
    "lastname": "Nilsson",
    "created_at": "2014-02-20T13:43:36.825Z",
    "updated_at": "2014-02-20T13:44:48.659Z",
    "links": {
        "self": "http://api.lvh.me:3000/users/fe1f7857-1612-49c6-8131-f4a93c9fdd62"
    }
}
```
)
