class CreateJoinTableGossipTags < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_gossip_tags do |t|
      t.references :tag, foreign_key: true, index: true
      t.timestamps
    end
  end
end
