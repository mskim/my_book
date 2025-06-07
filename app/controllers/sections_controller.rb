class SectionsController < ApplicationController
  

  before_action :set_section, only: [:show, :edit, :update, :destroy]

  def index
    @sections = Section.all

    @sections = @sections
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to edit_section_path(@section), notice: 'section was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @section.update(section_params)
      redirect_to edit_section_path(@section), notice: 'section was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @section.destroy
    redirect_to sections_path, notice: 'section was successfully destroyed.'
  end

  def remove_image
    @section.image.purge
    redirect_to edit_section_path(section), notice: 'Image removed successfully.'
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:position, :title, :chapter)
  end
end
