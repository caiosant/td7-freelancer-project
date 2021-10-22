class ProposalCancelationsController < ApplicationController

    def new
        @proposal = Proposal.find(params[:proposal_id])
        @project = Project.find(params[:project_id])
        @proposal_cancelation = ProposalCancelation.new()
    end

    def create
        @proposal_cancelation = ProposalCancelation.new(proposal_cancelation_params)
        @proposal_cancelation.proposal = Proposal.find(params[:proposal_id])
        
        if @proposal_cancelation.save
            redirect_to my_proposals_path
        else
            render :new
        end
    end

    private

    def proposal_cancelation_params
        params.require(:proposal_cancelation).permit(:reason)
    end
end
