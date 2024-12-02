require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:video) { create(:video, user: user) }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "when the user likes the video for the first time" do
      it "creates a like for the video" do
        expect {
          post video_likes_path(video)
        }.to change(Like, :count).by(1)

        expect(response).to redirect_to(video_path(video))
      end
    end

    context "when the user has already liked the video" do
      before do
        create(:like, user: user, video: video)
      end

      it "does not create a duplicate like" do
        expect {
          post video_likes_path(video)
        }.to_not change(Like, :count)

        expect(response).to redirect_to(video_path(video))
      end
    end
  end

  describe "DELETE #destroy" do
    context "when the user has liked the video" do
      before do
        create(:like, user: user, video: video)
      end

      it "removes the like" do
        expect {
          delete video_like_path(video)
        }.to change(Like, :count).by(-1)

        expect(response).to redirect_to(video_path(video))
      end
    end

    context "when the user has not liked the video" do
      it "does not remove any like" do
        expect {
          delete video_like_path(video)
        }.to_not change(Like, :count)

        expect(response).to redirect_to(video_path(video))
      end
    end
  end
end
