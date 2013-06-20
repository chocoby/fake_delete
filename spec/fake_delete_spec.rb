require 'spec_helper'

class FakeModel < ActiveRecord::Base
  include FakeDelete
  fake_delete
end

describe FakeDelete do
  let(:record) do
    FakeModel.create(title: "Fake City")
  end

  describe "#destroy" do
    before do
      record.destroy
      record
    end

    it { expect(record).to be_deleted }
    it { expect(record.deleted).to be > 0 }
    it { expect { FakeModel.find(record.id) }.to raise_error(ActiveRecord::RecordNotFound) }
  end

  describe "#recover" do
    before do
      record.destroy
      record.recover
      record
    end

    it { expect(record).to_not be_deleted }
    it { expect(record.deleted).to be 0 }
    it { expect(FakeModel.find(record.id)).to eq record }
  end
end
