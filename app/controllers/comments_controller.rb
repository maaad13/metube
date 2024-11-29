class CommentsController < ApplicationController
  before_action :find_video

  def create
    @comment =@video.comments.new(comment_params)
    @comment.user =current_user 
    if @comment.save
      redirect_to video_path(@video)
    else
      redirect_to video_path(@video)
    end
  end

  def destroy
    @comment =@video.comments.find(params[:id])
    if @comment.destroy
      redirect_to video_path(@video)
    else
      redirect_to video_path(@video)
    end
  end

  private
  def find_video
    @video=Video.find(params[:video_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
