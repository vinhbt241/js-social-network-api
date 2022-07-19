class Api::CommentsController < ApplicationController
  def create 
    Comment.create(content: params[:content], post_id: params[:post_id], user_id: params[:user_id])
  end
end
