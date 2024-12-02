require 'rails_helper'

RSpec.describe WatchCount, type: :model do
  let(:video) { create(:video) }

  subject { described_class.new(ip_address: "192.168.0.1", video: video) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without an ip_address" do
      subject.ip_address = nil
      expect(subject).to_not be_valid
    end 

    it "is not valid without a video" do
      subject.video = nil
      expect(subject).to_not be_valid
    end
  end

  describe "associations" do
    it { should belong_to(:video).dependent(:destroy) }
  end
end
