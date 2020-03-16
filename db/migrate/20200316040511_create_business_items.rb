class CreateBusinessItems < ActiveRecord::Migration[6.0]
  def change
    create_table :business_items do |t|
      t.integer :user_id
      t.integer :business_id
      t.integer :item_id
      t.string :availability
      t.timestamps
    end
  end
end
