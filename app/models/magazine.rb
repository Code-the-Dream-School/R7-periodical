class Magazine < ApplicationRecord
    has_many :subscriptions
    has_many :subscribers, through: :subscriptions
end
