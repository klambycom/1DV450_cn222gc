# id              integer, not null
# name            varchar(50), not null
# url             varchar(255), default "", not null
# description     varchar(255), default "", not null
# public          boolean, default false
# access_token    varchar(255), not null
# created_at      datetime
# updated_at      datetime
#
class App < ActiveRecord::Base
  before_create :generate_access_token

  validates :name, presence: true
  validates :url, presence: true
  validates :description, presence: true

  private

    def generate_access_token
      begin
        self.access_token = SecureRandom.hex
      end while self.class.exists? access_token: access_token
    end
end
