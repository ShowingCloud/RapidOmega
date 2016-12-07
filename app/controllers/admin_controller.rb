class AdminController < ApplicationController
  include Admin::SessionsHelper
  before_action :require_admin
end
