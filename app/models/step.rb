class Step < ApplicationRecord
  DEFAULT_CONTENT_STRING = 'Enter step descripion here...'

  has_one :image, as: :attachable

  belongs_to :recipe
end
