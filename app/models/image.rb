class Image < ApplicationRecord
  ALT_TEXT_CHAR_LIMIT = 250

  belongs_to :recipe
  has_many :parsed_lined

  has_one_attached :file

  def blob
    file.blob
  end
end
