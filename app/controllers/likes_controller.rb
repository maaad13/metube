class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_video

  def create
    like = @video.likes.find_or_initialize_by(user: current_user)
    if like.persisted?
      redirect_to @video
    else
      like.save
      redirect_to @video
    end
  end

  def destroy
    like = @video.likes.find_by(user: current_user)
    if like
      like.destroy
      redirect_to @video
    else
      redirect_to @video
    end
  end

  private
  def find_video
    @video = Video.find(params[:video_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
