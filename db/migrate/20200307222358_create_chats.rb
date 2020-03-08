class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.text :message
      t.references :user
      t.references :room

      t.timestamps
    end
  end
end
