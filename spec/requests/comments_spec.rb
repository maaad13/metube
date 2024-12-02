require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:video) { create(:video, user: user) }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new comment" do
        expect {
          post video_comments_path(video), params: { comment: { content: "test comment" } }
        }.to change(Comment, :count).by(1)
        expect(response).to redirect_to(video_path(video))
        expect(flash[:notice]).to eq("Comment created successfully.")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:comment) { create(:comment, video: video, user: user) }

    it "deletes the comment" do
      expect {
        delete video_comment_path(video, comment)
      }.to change(Comment, :count).by(-1)
      expect(response).to redirect_to(video_path(video))
      expect(flash[:notice]).to eq("Comment deleted successfully.")
    end

    it "fails to delete a non-existing comment" do
      allow_any_instance_of(Comment).to receive(:destroy).and_return(false)
      expect {
        delete video_comment_path(video, comment)
      }.to_not change(Comment, :count)
      expect(response).to redirect_to(video_path(video))
      expect(flash[:alert]).to eq("Failed to delete comment.")
    end
  end
end
