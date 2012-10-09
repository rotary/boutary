class StoreController < ApplicationController

  def index
    reset_session if session[:started_at].is_a?(Time) and session[:started_at] > Time.now - 5.hours
  end

  def authenticate
    if params[:password].to_s.mb_chars.upcase == "LISBOA2013"
      session[:started_at] = Time.now
      redirect_to :action => :select_product
    else
      redirect_to :action => :index
    end
  end

  def select_product
    unless session[:started_at]
      redirect_to :action => :index
      return
    end
    @products = Product.all
  end

end
