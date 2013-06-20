ActiveRecord::Schema.define(version: 1) do
  create_table :fake_models, force: true do |t|
    t.column :title, :string
    t.column :deleted, :integer, null: false, default: 0
  end
end
