class FreelancersFavoritesController < ApplicationController
  def create
    @freelancer_favorite = FreelancerFavorite.new
    @freelancer_favorite.freelancer = Profile.find(params[:profile_id]).freelancer
    @freelancer_favorite.project_owner = current_project_owner

    redirect_to profile_path(params[:profile_id]) if @freelancer_favorite.save
  end

  def destroy
    @freelancer_favorite = FreelancerFavorite.find(params[:id])
    @freelancer_favorite.destroy
    redirect_to profile_path(Profile.find(params[:profile_id]))
  end
end
