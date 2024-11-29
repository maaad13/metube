class VideosController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @videos = Video.includes(:watch_counts).all
    @videos=Video.all
  end

  def new
    @video = Video.new
  end

  def show 
    @video = Video.find(params[:id])
    @videos = Video.where.not(id: @video.id).order(created_at: :desc).limit(10)
    @videos = Video.accessible_by(current_ability).where.not(id: @video.id).order(created_at: :desc).limit(10)
  end

  def create
    @video = current_user.videos.new(video_params)
    if @video.save
      redirect_to @video, notice: "Video Uploaded Successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def edit
    @video=Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      redirect_to @video, notice: "Video updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @video=Video.find(params[:id])
    @video.destroy
    redirect_to @video 
  end

  private 
  def video_params
    params.require(:video).permit(:title, :description, :file)
  end
end
