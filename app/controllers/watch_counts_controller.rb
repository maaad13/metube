class WatchCountsController < ApplicationController
  before_action :set_video

  def create
    @video = Video.find(params[:video_id])

    unless @video.watch_counts.exists?(ip_address: request.remote_ip)
      @video.watch_counts.create(ip_address: request.remote_ip)
      flash[:notice] = "Watch count incremented."
    else
      flash[:alert] = "You have already watched this video."
    end
    redirect_to @video
  end

  private 
  def set_video
    @video=Video.find(params[:video_id])
  end
end
