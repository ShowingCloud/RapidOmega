class Rule < ApplicationRecord
  has_many :response_rules, :dependent => :destroy
  has_many :responses, through: :response_rules
  validates :event, presence: true
end
