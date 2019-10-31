class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:create, :edit, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    gossip = Gossip.find(params[:gossip_id])
    @comments = gossip.comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(content: comment_params[:content], gossip_id: comment_params[:gossip_id], user_id: current_user.id)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to gossip_path(params[:gossip_id]), notice: 'Ton commentaire a bien été ajouté' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render 'gossips/#{params[:gossip_id]}' } #Pas sûr que cela fonctionne
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :gossip_id)
    end

    #Vérifier que le user est connecté pour gossiper
    def authenticate_user
      unless current_user
        flash[:danger] = "Please log in."
        redirect_to new_session_path
      end
    end
end
