class AddReferenceTagGossip < ActiveRecord::Migration[5.2]
  def change
    add_reference :join_table_gossip_tags, :gossip, foreign_key: true
  end
end
