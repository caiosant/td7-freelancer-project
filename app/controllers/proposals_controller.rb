class ProposalsController < ApplicationController
    before_action :authenticate_person!
    before_action :completed_profile?

    def show
        @proposal = Proposal.find(params[:id])
        @freelancer = @proposal.freelancer
    end

    def create
        @proposal = Proposal.new(proposal_params)
        @proposal.freelancer = current_freelancer
        @proposal.project = Project.find(params[:project_id])
        @proposal.save

        redirect_to root_path
    end

    def my_proposals
        @proposals = current_freelancer.proposals
    end

    def accept
        @proposal = Proposal.find(params[:id])
        @proposal.accepted!
        redirect_to @proposal.project
    end

    def reject
        @proposal = Proposal.find(params[:id])
        @proposal.rejected!
        redirect_to @proposal.project
    end

    def cancel
        @proposal = Proposal.find(params[:id])
        @proposal.canceled!
        redirect_to my_proposals_path
    end

    private

    def proposal_params
        params.require(:proposal).permit(:application_reason, :hour_value, :hours, :deadline_proposal)
    end

    def authenticate_person!
        return if freelancer_signed_in? || project_owner_signed_in?

        redirect_to root_path
    end
end