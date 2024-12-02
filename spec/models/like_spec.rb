require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) {create:user}
  let(:video) {create(:video)}

  subject { described_class.new(user:user, video:video) } 

  describe "validations" do
    it "is valid for valid attributes" do
      expect(subject).to be_valid  
    end
  end
  describe "association" do
    it { should belong_to(:user) }
    it { should belong_to(:video) }  
  end
end
