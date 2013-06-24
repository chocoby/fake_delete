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
    it { expect(FakeModel.first).to be_nil }
    it { expect(FakeModel.all).to be_empty }
  end

  describe "#recover" do
    before do
      record.destroy
      record.recover
      record
    end

    it { expect(record).to_not be_deleted }
    it { expect(record.deleted).to be 0 }
    it { expect(FakeModel.first).to eq record }
    it { expect(FakeModel.all).to include record }
  end

  describe "#deleted?" do
    context "not deleted" do
      it { expect(record).to_not be_deleted }
    end

    context "deleted" do
      before { record.destroy }
      it { expect(record).to be_deleted }
    end
  end
end
