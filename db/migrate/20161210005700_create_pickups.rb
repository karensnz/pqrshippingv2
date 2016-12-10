class CreatePickups < ActiveRecord::Migration
  def change
    create_table :pickups do |t|
      t.integer :user_id
      t.datetime :date
      t.string :materials_needed
      t.string :package_destination
      t.string :image_upload
      t.text :special_instructions

      t.timestamps

    end
  end
end
