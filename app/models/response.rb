class Response < ApplicationRecord
  enum msgtype: [:text,:mpnews,:image]
  has_many :response_rules, :dependent => :destroy
  has_many :rules, through: :response_rules
end
