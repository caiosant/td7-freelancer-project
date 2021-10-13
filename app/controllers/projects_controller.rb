class ProjectsController < ApplicationController
    before_action :authenticate_project_owner!, only: [:new, :create]

    def show
        @project = Project.find(params[:id])
    end
    
    def new
        @project = Project.new()
    end

    def create
        @project = Project.new(project_params)
        @project.project_owner = current_project_owner

        if @project.save
            redirect_to @project
        else
            render :new
        end
    end

    def my_projects
        @projects = current_project_owner.projects
    end

    private

    def project_params
        params.require(:project).permit(:title, :description, :max_value, 
                                        :deadline, :location)
    end
end
