ActiveRecord::Schema.define(version: 1) do
  create_table :users, force: true do |t|
    t.column :name, :string
    t.column :deleted, :integer, null: false, default: 0
  end
end
