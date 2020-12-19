class CreateMicroposts < ActiveRecord::Migration[4.2]
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    # since we expect to retrieve all the microposts associated with
    # a given user id in reverse order of creation,
    # Listing 10.1 adds an index (Box 6.2) on the user_id and created_at columns:
    add_index :microposts, %i[user_id created_at]
  end
end
