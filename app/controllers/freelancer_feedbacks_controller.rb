class FreelancerFeedbacksController < ApplicationController
    def new
        @project = Project.find(params[:project_id])
        @freelancer = Freelancer.find(params[:freelancer_id])
        @freelancer_feedback = FreelancerFeedback.new()
    end

    def create
        @project = Project.find(params[:project_id])
        @freelancer = Freelancer.find(params[:freelancer_id])
        @freelancer_feedback = FreelancerFeedback.new(feedback_params)

        @freelancer_feedback.project = @project
        @freelancer_feedback.freelancer = @freelancer

        if @freelancer_feedback.save
            redirect_to @project          
        else
            render :new
        end
    end

    def show
    end

    private

    def feedback_params
        params.require(:freelancer_feedback).permit(:grade, :coment)
    end
end