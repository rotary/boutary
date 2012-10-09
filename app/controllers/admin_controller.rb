class AdminController < ApplicationController
  before_filter :authenticate_user!

  def index
    redirect_to root_url
  end

end
