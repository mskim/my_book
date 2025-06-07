class Section < ApplicationRecord
  
  belongs_to :chapter
  has_many :key_words, dependent: :destroy
  validates :title, presence: true
  

  
end
