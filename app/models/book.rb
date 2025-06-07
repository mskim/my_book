class Book < ApplicationRecord
  include SlugGenerator

  has_many :chapters, dependent: :destroy 
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\-_]+\z/, message: 'only allows letters, numbers, hyphens, and underscores' }

  before_validation :generate_slug_if_blank

  def to_param
    slug
  end

  # show sample chapters when creating new book
  # check box for each shown sample chapter
  # when user clicks create chapters button, 
  # create a chapters for each checked sample chapter
  # create sections for each chapter
  # create key words for each section
  # create sample story for each section

  # we should create sample chapters with seeds.rb
  def self.chapter_topics
    [
      "Chapter 1_0: Introduction",
      "Chapter 1_1: Introduction",
      "Chapter 1_2: Introduction",

      "Chapter 2_0: about my parents",
      "Chapter 2_1: about my grand parents",
      "Chapter 2_2: about my parents family",

      "Chapter 2_0: Early Life",
      "Chapter 2_1: My brothers",
      "Chapter 2_2: My Sisters",

      "Chapter 2_3: Early Life",
      "Chapter 2_4: Early Life",
      "Chapter 2_5: Early Life",

      "Chapter 3_0: Elemtry School Life",
      "Chapter 3_1: Junior High School Life",
      "Chapter 3_2: High School Life",
      "Chapter 3_3: My college life",
      "Chapter 3_4: My graduate school life",
      "Chapter 3_5: My Ph.D. life",

      "Chapter 4_0: My First Love",
      "Chapter 4_1: How I met my first love",
      "Chapter 4_2: How I met my wife",

      "Chapter 5_0: How I met my children",
      "Chapter 5_1: About my children",
      "Chapter 5_2: About my family",


      "Chapter 6_0: My First Job",
      "Chapter 6_1: My Second Job",
      "Chapter 6_2: My Third Job",

      "Chapter 6_0: My First Business",
      "Chapter 6_1: My Second Business",
      "Chapter 6_2: My Third Business",
      
      "Chapter 5_0: Personal Life",
      "Chapter 5_1: Personal Life",
      "Chapter 5_2: Personal Life",

      "Chapter 6_0: Family",
      "Chapter 6_1: About my relatives",
      "Chapter 6_2: About my wife's family",

      "Chapter 7_0: About my Friends",
      "Chapter 7_1: About my close friends",
      "Chapter 7_2: About my school friends",
        
      "Chapter 8_0: Hobbies one",
      "Chapter 8_1: Hobbies two",
      "Chapter 8_2: Hobbies three",


      "Chapter 9_0: Achievements",
      "Chapter 9_1: Achievements",
      "Chapter 9_2: Achievements",

      "Chapter 9_3: My Travel to Asia",
      "Chapter 9_4: My Travel to Europe",
      "Chapter 9_5: My Travel to Africa",
      "Chapter 9_6: My Travel to Australia",
      "Chapter 9_7: My Travel to Americas",

      "Chapter 10_0: My Nering Home Life",
      "Chapter 10_1: My Future",
      "Chapter 10_2: Future",

      "Chapter 10_3: My Personal Philosophy",
      "Chapter 10_4: My Personal Beliefs",
      "Chapter 10_5: My Personal Values",

      "Chapter 10_3: Person that I admire most",
      "Chapter 10_4: Books that inspire me",
      "Chapter 10_5: Movies that inspire me",
    ]
  end

  def self.create_sample_chapters
    30.times do |i|
      Chapter.create(position: i, title: "Chapter #{i + 1}")
    end
  end

  private

  def generate_slug_if_blank
    if slug.blank? && title.present?
      generate_slug_by_name(:title)
    end
  end
  
end
