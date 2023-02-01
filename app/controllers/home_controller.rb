class HomeController < ApplicationController

  def index
    @communities = Community.all.order(created_at: :desc)
    @communities = Community.page(params[:page])
    # ransack search
    @search = Community.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty? 
    @communities = @search.result.page(params[:page])
  end
end


