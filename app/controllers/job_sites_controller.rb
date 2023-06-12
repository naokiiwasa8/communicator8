class JobSitesController < ApplicationController
  before_action :set_job_site, only: %i[ show edit update destroy ]

  # GET /job_sites or /job_sites.json
  def index
    @job_sites = JobSite.all.sort_by do |job_site|
      [
        -job_site.recommended_count,
        job_site.not_recommended_count
      ]
    end
  end

  # GET /job_sites/1 or /job_sites/1.json
  def show
  end

  # GET /job_sites/new
  def new
    @job_site = JobSite.new
  end

  # GET /job_sites/1/edit
  def edit
  end

  # POST /job_sites or /job_sites.json
  def create
    @job_site = JobSite.new(job_site_params)

    respond_to do |format|
      if @job_site.save
        format.html { redirect_to job_site_url(@job_site), notice: "Job site was successfully created." }
        format.json { render :show, status: :created, location: @job_site }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_sites/1 or /job_sites/1.json
  def update
    respond_to do |format|
      if @job_site.update(job_site_params)
        format.html { redirect_to job_site_url(@job_site), notice: "Job site was successfully updated." }
        format.json { render :show, status: :ok, location: @job_site }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_sites/1 or /job_sites/1.json
  def destroy
    @job_site.destroy

    respond_to do |format|
      format.html { redirect_to job_sites_url, notice: "Job site was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_site
      @job_site = JobSite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_site_params
      params.require(:job_site).permit(:name, :url, :description)
    end
end
