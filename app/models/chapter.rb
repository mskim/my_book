class Chapter < ApplicationRecord
  include SlugGenerator

  belongs_to :book, optional: true
  has_many :sections, dependent: :destroy
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\-_]+\z/, message: 'only allows letters, numbers, hyphens, and underscores' }

  
  before_validation :generate_slug, on: :create

  after_create :create_sections

  def to_param
    slug
  end

  private

  def generate_slug
    generate_slug_by_name(:title)
  end
  
  def create_sections
    5.times do |i|
      Section.create(position: i, title: "Section #{i + 1}", chapter: self)
    end
  end
end
