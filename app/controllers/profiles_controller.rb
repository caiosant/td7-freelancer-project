class ProfilesController < ApplicationController
    before_action :completed_profile?, except: [:edit, :update]
    before_action :authenticate_freelancer!, except: [:show]

    

    def show
        @profile = Profile.find(params[:id])
    end

    def edit
        @profile = Profile.find(params[:id])
    end

    def update
        @profile = Profile.find(params[:id])

        if @profile.update(profile_params)
            redirect_to @profile
        else
            render :edit
        end
    end

    private

    def profile_params
      params.require(:profile).permit(:full_name, :social_name, :birth_date, :description)
    end
end
