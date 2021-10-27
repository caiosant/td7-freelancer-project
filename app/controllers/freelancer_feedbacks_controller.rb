class FreelancerFeedbacksController < ApplicationController
    before_action :authenticate_project_owner!

    def new
        @project = Project.find(params[:project_id])
        @freelancer = Freelancer.find(params[:freelancer_id])
        
        if @project.project_status == 'finished' && @project.project_owner.id == current_project_owner.id && @project.proposals.where("freelancer_id = ?", @freelancer.id).present?
            @freelancer_feedback = FreelancerFeedback.new()
        else
            redirect_to root_path
        end
    end

    def create
        @project = Project.find(params[:project_id])
        @freelancer = Freelancer.find(params[:freelancer_id])
        
        if @project.project_status == 'finished' && @project.project_owner.id == current_project_owner.id && @project.proposals.where('freelancer_id = ?', @freelancer.id).present?
            @freelancer_feedback = FreelancerFeedback.new(feedback_params)
            @freelancer_feedback.project = @project
            @freelancer_feedback.freelancer = @freelancer

            if @freelancer_feedback.save
                redirect_to @project          
            else
                render :new
            end
        else
            redirect_to root_path
        end
    end

    def show
    end

    private

    def feedback_params
        params.require(:freelancer_feedback).permit(:grade, :coment)
    end
end