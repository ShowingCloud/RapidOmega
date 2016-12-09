class Admin < ApplicationRecord
  enum role: [:admin,:superadmin]
  has_secure_password
end
