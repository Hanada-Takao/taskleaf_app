class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :tag_name, null: false
      t.index :tag_name, :unique =>  true
      t.timestamps
    end
  end
end
