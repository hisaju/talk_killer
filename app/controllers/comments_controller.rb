class CommentsController < ApplicationController
  def create
    # Talkをパラメータの値から探し出し,Talkに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @talk = @comment.talk
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        #TODO:通知に関しての処理をModelに記載する
        #TODO:通知が保存されない
        format.html { redirect_to talk_path(@talk), notice: 'コメントを投稿しました' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    @talk = Talk.find(params[:talk_id])
    redirect_to talk_path(@talk)
  end
  
  def destroy
    @talk = Talk.find(params[:talk_id])
    @comment = @talk.comments
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if Comment.find(params[:id]).destroy
        format.html { redirect_to talk_path(@talk), notice: 'コメントを削除しました' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:talk_id, :content)
    end
end
