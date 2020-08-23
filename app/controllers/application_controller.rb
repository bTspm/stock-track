class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Clearance::Controller
  include Services
end
