class Recipe < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :parsed_lines, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :tools, dependent: :destroy

  belongs_to :web_recipe

  scope :with_attached_images, -> { includes(:images).merge(Image.with_attached_file) }
end
