require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:video) { create(:video) }

  subject {described_class.new(content:"content of comment", user:user, video:video)}
  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without content of comment" do
      subject.content = nil
      expect(subject).to_not be_valid  
    end
  end 

  describe "association" do
    it { should belong_to(:user) } 
    it { should belong_to(:video) } 
  end
end 
   