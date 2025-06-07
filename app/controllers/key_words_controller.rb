class KeyWordsController < ApplicationController
  include Pagy::Backend

  before_action :set_key_word, only: [:show, :edit, :update, :destroy]

  def index
    @key_words = Key_word.all

    @pagy, @key_words = pagy(@key_words, items: 12)
  end

  def new
    @key_word = Key_word.new
  end

  def create
    @key_word = Key_word.new(key_word_params)
    if @key_word.save
      redirect_to edit_key_word_path(@key_word.slug), notice: 'key_word was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @key_word.update(key_word_params)
      redirect_to edit_key_word_path(@key_word.slug), notice: 'key_word was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @key_word.destroy
    redirect_to key_words_path, notice: 'key_word was successfully destroyed.'
  end

  def remove_image
    @key_word.image.purge
    redirect_to edit_key_word_path(key_word_slug: @key_word.slug), notice: 'Image removed successfully.'
  end

  private

  def set_key_word
    @key_word = Key_word.find_by!(slug: params[:slug])
  end

  def key_word_params
    params.require(:key_word).permit(:word, :section, :slug)
  end
end
