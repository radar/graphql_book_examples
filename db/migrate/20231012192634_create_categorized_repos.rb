class CreateCategorizedRepos < ActiveRecord::Migration[7.1]
  def change
    create_table :categorized_repos do |t|
      t.references :category, null: false, foreign_key: true
      t.references :repo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
