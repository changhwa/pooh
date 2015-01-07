class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    render layout: false
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    if @project.save
      project = Project.find(@project.id)
      userids = params[:project][:user_ids]
      userids.each do |user_id|
        exists_user = project.entries.find_by_user_id(user_id)
        if exists_user == nil
          project.entries.create(user_id: user_id, project_id: project.id)
        end
      end
      render json: result_notice('프로젝트를 생성하였습니다'), status: :ok
    else
      render json: result_notice('프로젝트를 실패하였습니다'), status: :internal_server_error
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    project = Project.find(params[:project_id])
    userids = params[:user_ids]
    userids.each do |user_id|
      exists_user = project.entries.find_by_user_id(user_id)
      if exists_user == nil
        project.entries.create(user_id: user_id, project_id: project.id)
      end
    end
    render json: project
  end

  def tree
    project_tree = {}
    projects = Project.all
    projects.each do |project|
      users = project.users.select("users.id, users.email, users.name")
      project_tree = project.as_json
      user_tree = {}
      user_trees = []
      users.each do |user|
        user_tree = user.as_json
        user_tree[:article] = project.entries.find_by_user_id(user.id).articles
        user_trees.push user_tree
      end
      project_tree[:users] = user_trees
    end
    render json: project_tree
  end

  def entryList
    render json: Project.find(params[:project_id]).users.select("users.id, users.email, users.name")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description, :user_ids)
    end

    def result_notice(notice_msg)
      result = {}
      result[:notice] = notice_msg
      result
    end
end
