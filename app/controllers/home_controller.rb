class HomeController < ApplicationController
  before_action :completed_profile?
end
