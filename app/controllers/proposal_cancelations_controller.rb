class ProposalCancelationsController < ApplicationController
  def new
    @proposal = Proposal.find(params[:proposal_id])
    @project = Project.find(params[:project_id])
    @proposal_cancelation = ProposalCancelation.new
  end

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @project = Project.find(params[:project_id])
    @proposal_cancelation = ProposalCancelation.new(proposal_cancelation_params)
    @proposal_cancelation.proposal = @proposal

    if @proposal_cancelation.save
      @proposal.canceled!
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
