class ProfilesController < ApplicationController
  before_action :completed_profile?, except: %i[create edit update]
  before_action :authenticate_person!, only: [:show]
  before_action :authenticate_freelancer!, except: [:show]

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
    @occupation_area = OccupationArea.all
  end

  def update
    @profile = Profile.find(params[:id])
    @occupation_area = OccupationArea.all

    @profile.avatar.attach(params[:avatar]) if params[:avatar].present?

    if @profile.update(profile_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:full_name, :social_name, :birth_date, :description, :occupation_area_id, :avatar)
  end

  def authenticate_person!
    return if freelancer_signed_in? || project_owner_signed_in?

    redirect_to root_path
  end
end
