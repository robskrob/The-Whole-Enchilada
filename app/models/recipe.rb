class Recipe < ApplicationRecord
  has_many :images, dependent: :destroy

  # might need this to reduce 2N+1 queries. One query
  # for the recipe's images and another for each image's
  # ActiveStorage::Attachment
  # https://stackoverflow.com/questions/49510195/rails-5-2-active-storage-add-custom-attributes
  #
  # Might be worth expanding on this with a blog post. Could talk about
  # SQL and things to be careful with when making ActiveRecord Association
  # also why is this with_attached_file and not with_attached_images?
  scope :with_attached_images, -> { includes(:images).merge(Image.with_attached_file) }
end
