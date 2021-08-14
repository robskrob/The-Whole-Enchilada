class Image < ApplicationRecord

  ActiveStorage::Attachment.after_create_commit do
    image = Image.includes(:attachable).find(self.record_id)

    RecipesChannel.broadcast_to(image.attachable, {
      recipe_id: image.attachable_id,
      image_id: image.id,
      alt_text: image.alt_text,
      url: self.service_url
    })
  end

  ALT_TEXT_CHAR_LIMIT = 250

  belongs_to :attachable, polymorphic: true

  has_many :parsed_lined

  has_one_attached :file

  def blob
    file.blob
  end
end
