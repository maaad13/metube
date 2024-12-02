require 'rails_helper'

RSpec.describe "WatchCounts", type: :request do
  let(:user) { create(:user) }
  let(:video) { create(:video, user: user) }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "when the user watches the video for the first time" do
      it "increments the watch count" do
        expect {
          post video_watch_counts_path(video)
        }.to change(WatchCount, :count).by(1)
        
        expect(response).to redirect_to(video_path(video))
        expect(flash[:notice]).to eq("Watch count incremented.")
      end
    end

    context "when the user has already watched the video" do
      before do
        video.watch_counts.create(ip_address: "127.0.0.1")
      end

      it "does not increment the watch count again" do
        expect {
          post video_watch_counts_path(video)
        }.to_not change(WatchCount, :count)

        expect(response).to redirect_to(video_path(video))
        expect(flash[:alert]).to eq("You have already watched this video.")
      end
    end
  end
end
