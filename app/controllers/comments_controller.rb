class CommentsController < ApplicationController
  before_action :find_video

  def create
    @comment = @video.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to video_path(@video), notice: "Comment created successfully."
    else
      flash[:alert] = "Failed to create comment."
      redirect_to video_path(@video), status: :unprocessable_entity
    end
  end
  

  def destroy
    @comment = @video.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Comment deleted successfully."
    else
      flash[:alert] = "Failed to delete comment."
    end
    redirect_to video_path(@video)
  end

  private

  def find_video
    @video = Video.find(params[:video_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
