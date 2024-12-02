require 'rails_helper'

RSpec.describe "Videos", type: :request do
  let(:user) { create(:user) }
  let(:video) { create(:video, user: user) }

  before do
    sign_in user
  end
  
  describe "GET #index" do
    it "assigns all videos to @videos" do
      video 
      get videos_path
      expect(assigns(:videos)).to include(video)
      expect(response).to be_successful  
    end
  end

  describe "GET #new" do
    it "assigns a new video to @video" do
      get new_video_path
      expect(assigns(:video)).to be_a_new(Video)
      expect(response).to be_successful    
    end
  end

  describe "GET #show" do
    it "assigns the requested video to @video" do
      get video_path(video)
      expect(assigns(:video)).to eq(video)
      expect(response).to be_successful    
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new video" do
        expect {
          post videos_path, params: { video: { 
            title: "Test Title", 
            description: "Test Description", 
            file: fixture_file_upload('test.mp4', 'video/mp4') 
          } }
        }.to change(Video, :count).by(1)
        expect(response).to redirect_to(assigns(:video))
        expect(flash[:notice]).to eq("Video Uploaded Successfully")
      end
    end

    context "without title attribute" do
      it "does not create a video without title" do
        expect {
          post videos_path, params: { video: { 
            title: "", 
            description: "Test Description", 
            file: fixture_file_upload('test.mp4', 'video/mp4') 
          } }
        }.to_not change(Video, :count)
        expect(response).to render_template(:new)
      end
    end

    context "without description attribute" do
      it "does not create a video without description" do
        expect {
          post videos_path, params: { video: { 
            title: "Test Title", 
            description: "", 
            file: fixture_file_upload('test.mp4', 'video/mp4') 
          } }
        }.to_not change(Video, :count)
        expect(response).to render_template(:new)
      end
    end
    
    context "without file attribute" do
      it "does not create a video without file" do
        expect {
          post videos_path, params: { video: { 
            title: "Test Title", 
            description: "Test Description", 
            file: nil 
          } }
        }.to_not change(Video, :count)
        expect(response).to render_template(:new)
      end
    end
  end
end
