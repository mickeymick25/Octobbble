class ShotsController < ApplicationController
  before_action :set_shot, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create]

  # GET /shots/1/edit
  def edit
    @project = Project.find(params[:project_id])
  end

  # POST /shots
  def create
    @project = Project.find(params[:project_id])
    @shot = @project.shots.create(shot_params)
    @shot.user_id = current_user.id if current_user # assigns logged in user's ID to comment
    @shot.save!

    redirect_to @project
  end

  # PATCH/PUT /shots/1
  def update
    @project = Project.find(params[:project_id])
    respond_to do |format|
      if @shot.update(shot_params)
        format.html { redirect_to [@project, @shot], notice: 'Shot was successfully updated.' }
        format.json { render :show, status: :ok, location: @shot }
      else
        format.html { render :edit }
        format.json { render json: @shot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shots/1
  def destroy
    @project = Project.find(params[:project_id])
    @shot.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Shot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shot
      @shot = Shot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shot_params
      params.require(:shot).permit(:title, :description, :s3_key, :mime_type)
    end
end
