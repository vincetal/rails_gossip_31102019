class User < ApplicationRecord
  belongs_to :city
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage", dependent: :destroy
  has_many :sent_messages, foreign_key: 'recipient_id', class_name: "JoinTableMessageRecipient", dependent: :destroy
  has_many :gossips, dependent: :destroy
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true
  has_many :comments, dependent: :destroy
end
