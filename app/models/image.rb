class Image < ApplicationRecord
  belongs_to :recipe
  has_many :parsed_lined

  has_one_attached :file

  def blob
    file.blob
  end
end
