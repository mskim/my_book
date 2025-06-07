class ChaptersController < ApplicationController
  include Pagy::Backend

  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  def index
    @chapters = Chapter.all

    @pagy, @chapters = pagy(@chapters, items: 12)
  end

  def new
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new(chapter_params)
    if @chapter.save
      redirect_to edit_chapter_path(@chapter.slug), notice: 'chapter was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @chapter.update(chapter_params)
      redirect_to edit_chapter_path(@chapter.slug), notice: 'chapter was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chapter.destroy
    redirect_to chapters_path, notice: 'chapter was successfully destroyed.'
  end

  def remove_image
    @chapter.image.purge
    redirect_to edit_chapter_path(chapter_slug: @chapter.slug), notice: 'Image removed successfully.'
  end

  private

  def set_chapter
    @chapter = Chapter.find_by!(slug: params[:slug])
  end

  def chapter_params
    params.require(:chapter).permit(:position, :title, :book, :slug)
  end
end
