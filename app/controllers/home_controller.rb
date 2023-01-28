class HomeController < ApplicationController

  def index
    @communities = Community.all.order(created_at: :desc)
  end
end


