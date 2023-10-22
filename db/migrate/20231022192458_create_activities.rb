class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.references :repo, null: false, foreign_key: true
      t.references :event, polymorphic: true, null: false

      t.timestamps
    end
  end
end
