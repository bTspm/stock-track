class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Services
end
