require 'spec_helper'

class FakeModel < ActiveRecord::Base
  include FakeDelete
  fake_delete
end

describe FakeDelete do
  let!(:record) do
    FakeModel.create!(title: "Fake City")
  end

  describe "#destroy" do
    before { record.destroy }

    it { expect(record.deleted).to be > 0 }
    it { expect(record).to_not be_changed }
    it { expect(FakeModel.first).to be_nil }
    it { expect(FakeModel.all).to be_empty }
  end

  describe "#recover" do
    before do
      record.destroy
      record.recover
    end

    it { expect(record.deleted).to be 0 }
    it { expect(record).to_not be_changed }
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

  describe ".only_deleted" do
    let!(:record2) { FakeModel.create!(title: "Hey") }
    let!(:records) { FakeModel.only_deleted }

    before { record.destroy }

    it { expect(records.count).to be 1 }
    it { expect(records.first).to eq record }
  end

  describe ".with_deleted" do
    let!(:record2) { FakeModel.create!(title: "Hey") }
    let!(:records) { FakeModel.with_deleted }

    it { expect(records.count).to be 2 }
    it { expect(records.first).to eq record }
    it { expect(records.second).to eq record2 }
  end
end
