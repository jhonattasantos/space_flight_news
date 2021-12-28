class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events,id: :uuid do |t|
      t.string :origin_id
      t.string :provider

      t.timestamps
    end
  end
end
