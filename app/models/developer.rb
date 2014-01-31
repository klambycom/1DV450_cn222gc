# id              integer, not null
# email           varchar(254), not null
# password_digest varchar(255), not null
# created_at      datetime
# updated_at      datetime

class Developer < ActiveRecord::Base
  has_secure_password

  validates :email, presence: { message: "Du måste ange en e-postadress" },
                    uniqueness: true

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                              presence: { message: "Felaktig e-postadress" }
end
