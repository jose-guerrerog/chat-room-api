class Message < ApplicationRecord
  belongs_to :room

  validates :content, presence: true
  validates :sender_name, presence: true

  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
