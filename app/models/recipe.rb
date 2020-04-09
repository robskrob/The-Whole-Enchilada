class Recipe < ApplicationRecord
  has_many :images, dependent: :destroy

  scope :with_attached_images, -> { includes(:images).merge(Image.with_attached_file) }
end
