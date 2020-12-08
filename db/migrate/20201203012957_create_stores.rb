class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores, id: :uuid do |t|
      t.string :name
      t.uuid :shopkeeper_id

      t.timestamps
    end
  end
end