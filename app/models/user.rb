class User < ApplicationRecord
    has_many :accomplishments, dependent: :destroy
    has_many :expectations, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :emails, dependent: :destroy
end
