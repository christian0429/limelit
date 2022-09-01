class ProjectsController < ApplicationController
before_action :set_project, only: :show


  def show
    authorize @project
    @booking = Booking.new
    authorize @booking
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def index
    @projects = policy_scope(Project)
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.organization = current_organization

    authorize @project

    if @project.save!
      redirect_to root_path, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name,
                                    :description,
                                    :category,
                                    :address,
                                    :city,
                                    :available_spots,
                                    :start_date,
                                    :end_date)
  end
end
