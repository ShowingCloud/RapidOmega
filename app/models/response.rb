class Response < ApplicationRecord
  has_many :response_rules
  has_many :rules, through: :response_rules
end
