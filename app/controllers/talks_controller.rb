class TalksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_talk, only: [:show, :edit, :update, :destroy]

  def index
    @talks = Talk.all.includes(:replies, :comments)
  end

  def show
    @comment   = @talk.comments.build
    @comments  = @talk.comments
    @summary   = @talk.summaries.build
    @summaries = @talk.summaries
    #@reply     = @comment.replies.build
    #@replies   = @comment.replies
  end

  def new
    @talk = Talk.new
  end

  def edit
  end

  def create
    @talk = Talk.new(talk_params)
    @talk.user_id = current_user.id

    respond_to do |format|
      if @talk.save
        format.html { redirect_to @talk, notice: 'トークが作成されました' }
        format.json { render :show, status: :created, location: @talk }
      else
        format.html { render :new }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @talk.update(talk_params)
        format.html { redirect_to @talk, notice: 'トークが更新されました' }
        format.json { render :show, status: :ok, location: @talk }
      else
        format.html { render :edit }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @talk.destroy
    respond_to do |format|
      format.html { redirect_to talks_url, notice: 'トークが削除されました' }
      format.json { head :no_content }
    end
  end

  private
    def set_talk
      @talk = Talk.find(params[:id])
    end

    def talk_params
      params.require(:talk).permit(:title, :content, :status, :due_date, :picture)
    end
end
