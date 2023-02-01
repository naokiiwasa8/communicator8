class HomeController < ApplicationController

  def index
    @communities = Community.all.order(created_at: :desc)
    @communities = Community.page(params[:page])
  end
end


