class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_user_is_owner, only: [:edit, :update, :destroy]
  before_action :set_s3_direct_post, only: [:show]

  # GET /projects
  def index
    @projects = Project.all.order('updated_at DESC')
  end

  # GET /projects/1
  # GET /projects/1?octopod_id=
  def show
    @new_shot = @project.shots.build
    if !TeamCreator.team(params[:octopod_id]).empty?
      @activities = TeamCreator.team(params[:octopod_id])
      Rails.logger.info "Team is not empty!"
    end
  end

  # GET /projects/new
  # GET /projects/new?octopod_id=
  def new
    @project = StoryCreator.call(params[:octopod_id])
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = current_user.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Le projet a été crée avec succès.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  def update
    # @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Le projet a été mis à jour avec succès.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:title, :description, :cover, :clientname, :clientlogo)
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201')
    end

    def check_user_is_owner
      unless user_signed_in? && current_user == @project.user
        flash[:error] = "Vous n'avez pas le droit de modifier ce projet"
        redirect_to project_path(@project)
      end
    end
end
