class CreateFriendRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_relationships do |t|
      t.integer :requester_id
      t.integer :acceptor_id
      t.boolean :confirmed, default: false

      t.index :requester_id
      t.index :acceptor_id
      t.timestamps
    end
  end
end
