# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

member = User.create(firstname: "John",
                     lastname: "Doe",
                     email: "john@doe.com",
                     password: "hemligt",
                     password_confirmation: "hemligt")

rockTag = Tag.create(tag: "Rock")
psychedelicTag = Tag.create(tag: "Psykedelisk")
Tag.create(tag: "77-punk")
Tag.create(tag: "Hardcore")
Tag.create(tag: "Trallpunk")

videoResourceType = ResourceType.create(name: "Video")

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
