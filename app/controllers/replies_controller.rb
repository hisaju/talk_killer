class RepliesController < ApplicationController
  
  def index
    @comment = Comment.find_by_id(params[:comment_id])
    @reply     = @comment.replies.build
    @replies   = @comment.replies
  end
  
  def create
    # Talkをパラメータの値から探し出し,Talkに紐づくrepliesとしてbuildします。
    @reply = current_user.replies.build(reply_params)
    #[TODO]comment_id,talk_idを代入、上記のコードを改善すると不要？
    @reply.comment_id=params[:comment_id]
    @reply.talk_id=params[:talk_id]
    #@talk = @reply.talk
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @reply.save
        #TODO:通知に関しての処理をModelに記載する
        #TODO:通知が保存されない
        format.html { redirect_to talk_comment_replies_path, notice: 'コメントに返信しました' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end
  
  def edit
    @reply = Reply.find(params[:id])
  end
  
  def update
    @reply = Reply.find(params[:id])
    @reply.update(reply_params)
    redirect_to :action => "index"
  end
  
  def destroy
    @talk   = Talk.find_by_id(params[:talk_id])
    @coment = Comment.find_by_id(params[:comment_id])
    @replies  = @talk.replies
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if Reply.find(params[:id]).destroy
        format.html { redirect_to :action => "index", notice: 'リプライを削除しました' }
        format.js   { render :index }
      else
        format.html { render :new }
      end
    end
  end

  private
    # ストロングパラメーター
    def reply_params
      params.require(:reply).permit(:talk_id, :comment_id, :content)
    end
end
