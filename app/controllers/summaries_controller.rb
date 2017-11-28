class SummariesController < ApplicationController
  def create
    # Talkをパラメータの値から探し出し,Talkに紐づくsummariesとしてbuildします。
    @summary = current_user.summaries.build(summary_params)
    @talk = @summary.talk
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @summary.save
        #TODO:通知に関しての処理をModelに記載する
        #TODO:通知が保存されない
        format.html { redirect_to talk_path(@talk), notice: '要約を作成しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end
  
  def edit
    @summary = Summary.find(params[:id])
  end
  
  def update
    @summary = Summary.find(params[:id])
    @summary.update(summary_params)
    @talk = Talk.find(params[:talk_id])
    redirect_to talk_path(@talk)
  end
  
  def destroy
    @talk = Talk.find(params[:talk_id])
    @summary = @talk.summaries
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if Summary.find(params[:id]).destroy
        format.html { redirect_to talk_path(@talk), notice: '要約を削除しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  private
    # ストロングパラメーター
    def summary_params
      params.require(:summary).permit(:talk_id, :content)
    end
end
