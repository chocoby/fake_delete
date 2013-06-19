require 'spec_helper'

class User < ActiveRecord::Base
  include FakeDelete
  fake_delete
end

describe FakeDelete do
  let(:record) do
    User.create(name: "Fake")
  end

  describe "#destroy" do
    before do
      record.destroy
      record
    end

    it { expect(record).to be_deleted }
    it { expect(record.deleted).to be > 0 }
    it { expect { User.find(record.id) }.to raise_error(ActiveRecord::RecordNotFound) }
  end

  describe "#recover" do
    before do
      record.destroy
      record.recover
      record
    end

    it { expect(record).to_not be_deleted }
    it { expect(record.deleted).to be 0 }
    it { expect(User.find(record.id)).to eq record }
  end
end
