class Recipe < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :parsed_lines, dependent: :destroy

  scope :with_attached_images, -> { includes(:images).merge(Image.with_attached_file) }
end
