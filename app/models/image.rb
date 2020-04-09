class Image < ApplicationRecord
  belongs_to :recipe

  has_one_attached :file
end
