class CreateArticlesLaunches < ActiveRecord::Migration[6.1]
  def change
    create_table :articles_launches do |t|
      t.references :article, null: false, foreign_key: true
      t.references :launch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
