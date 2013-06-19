# FakeDelete

"Soft-delete" gem for Rails 3 (also Rails 4?). It can enable the unique constraint by database.

**IMPORTANT**: EXPERIMENTAL VERSION!

## Installation

Add this line to your application's Gemfile:

    gem 'fake_delete'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fake_delete

## Usage

migration:

    add_column :users, :deleted, :integer, null: false, default: 0
    add_index :users, [:login_name, :deleted], unique: true

model:

    class User < ActiveRecord::Base
      include FakeDelete
      fake_delete
    end

delete:

    user = User.find(1)
    user.destroy

recover:

    user = User.with_deleted.find(1)
    user.recover

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
