class Rule < ApplicationRecord
  has_many :response_rules
  has_many :responses, through: :response_rules
  validates :case, presence: true, uniqueness: true
end
