class KeyWord < ApplicationRecord
  include SlugGenerator

  belongs_to :section
  validates :word, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\-_]+\z/, message: 'only allows letters, numbers, hyphens, and underscores' }

  
  before_validation :generate_slug, on: :create

  after_create :create_key_words

  def to_param
    slug
  end

  private

  def generate_slug
    generate_slug_by_name(:word)
  end
  
  def create_key_words
    5.times do |i|
      KeyWord.create(position: i+1, word: "KeyWord #{i + 1}", section: self)
    end
  end
end
