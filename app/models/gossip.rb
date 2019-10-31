class Gossip < ApplicationRecord
  validates :title,
    presence: true,
    length: { minimum: 3, maximum: 140 }
  validates :content, presence: true
  has_many :join_table_gossip_tags, dependent: :destroy
  has_many :tags, through: :join_table_gossip_tags,  dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
end
