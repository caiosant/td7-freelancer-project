class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    if (freelancer_signed_in? && current_freelancer.profile.valid?) || project_owner_signed_in?
      root_path
    else
      edit_profile_path(current_freelancer.profile.id)
    end
  end

  def completed_profile?
    if freelancer_signed_in? && current_freelancer.profile.valid? == false
      redirect_to edit_profile_path(current_freelancer.profile.id)
    end
  end
end
