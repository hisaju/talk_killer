class RepliesController < ApplicationController
  def create
    # Talkをパラメータの値から探し出し,Talkに紐づくrepliesとしてbuildします。
    @reply = current_user.replies.build(reply_params)
    @talk = @reply.talk
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @reply.save
        #TODO:通知に関しての処理をModelに記載する
        #TODO:通知が保存されない
        format.html { redirect_to talk_path(@talk), notice: 'コメントに返信しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end
  
  def edit
    @reply = Comment.find(params[:id])
  end
  
  def update
    @reply = Comment.find(params[:id])
    @reply.update(reply_params)
    @talk = Talk.find(params[:talk_id])
    redirect_to talk_path(@talk)
  end
  
  def destroy
    @talk = Talk.find(params[:talk_id])
    @reply = @talk.replies
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if Comment.find(params[:id]).destroy
        format.html { redirect_to talk_path(@talk), notice: 'リプライを削除しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  private
    # ストロングパラメーター
    def reply_params
      params.require(:reply).permit(:talk_id, :content)
    end
end
