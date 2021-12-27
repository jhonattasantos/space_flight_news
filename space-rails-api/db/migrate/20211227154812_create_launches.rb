class CreateLaunches < ActiveRecord::Migration[6.1]
  def change
    create_table :launches do |t|
      t.string :origin_id
      t.string :provider

      t.timestamps
    end
  end
end
