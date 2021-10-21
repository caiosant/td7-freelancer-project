class ProjectsController < ApplicationController
    before_action :completed_profile?
    before_action :authenticate_project_owner!, only: [:new, :create]


    def index
        @projects = Project.all
    end

    def show
        @project = Project.find(params[:id])
        @proposal = Proposal.new()
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
        if current_project_owner != nil
            @projects = current_project_owner.projects
        elsif current_freelancer != nil
            @proposals = current_freelancer.proposals
        end
    end

    def finish
        @project = Project.find(params[:id])
        @project.finished!
        redirect_to @project
    end

    def search
        @projects = Project.where('title like ? OR description like ?', "%#{params[:q]}%", "%#{params[:q]}%")
    end
    
    private

    def project_params
        params.require(:project).permit(:title, :description, :max_value, 
                                        :deadline, :location, ability_ids: [])
    end
end
