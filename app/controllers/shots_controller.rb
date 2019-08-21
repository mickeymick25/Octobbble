class ShotsController < ApplicationController
  before_action :set_shot, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create]

  # GET /shots
  def index
    @shots = Shot.all
  end

  # GET /shots/1
  def show
  end

  # GET /shots/new
  def new
    @project = Project.find(params[:project_id])
    @shot = current_user.shots.build
  end

  # GET /shots/1/edit
  def edit
    @project = Project.find(params[:project_id])
  end

  # POST /shots
  def create
    # finds the project with the associated project_id
    @project = Project.find(params[:project_id])
    # creates the comment on the shot passing in params
    @shot = @project.shots.create(shot_params)
    @shot.user_id = current_user.id if current_user # assigns logged in user's ID to comment
    @shot.save!

    #@shot = current_user.shots.build(shot_params)
    # @shot = Shot.new(shot_params)
    redirect_to @project
    # respond_to do |format|
    #   if @shot.save
    #     format.html { redirect_to @shot, notice: 'Shot was successfully created.' }
    #     format.json { render :show, status: :created, location: @shot }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @shot.errors, status: :unprocessable_entity }
    #   end
    # end
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
      params.require(:shot).permit(:title, :description, :s3_key)
    end
end
