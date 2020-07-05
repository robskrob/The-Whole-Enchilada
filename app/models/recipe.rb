class Recipe < ApplicationRecord
  has_many :images, dependent: :destroy, as: :attachable
  has_many :ingredients, -> { where(deleted: false) }, dependent: :destroy
  has_many :parsed_lines, dependent: :destroy
  has_many :parsed_long_lines, dependent: :destroy
  has_many :steps, -> { where(deleted: false) }, dependent: :destroy
  has_many :tools, -> { where(deleted: false) }, dependent: :destroy
  has_many :tips, -> { where(deleted: false) }, dependent: :destroy

  belongs_to :web_recipe, optional: true
  belongs_to :user, optional: true

  scope :with_attached_images, -> { includes(:images).merge(Image.with_attached_file) }
end
