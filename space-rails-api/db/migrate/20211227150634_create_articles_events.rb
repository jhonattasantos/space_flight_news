class CreateArticlesEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :articles_events,:id => false do |t|
      t.references :article, null: false, foreign_key: true, type: :uuid
      t.references :event, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
