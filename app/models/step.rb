class Step < ApplicationRecord
  DEFAULT_CONTENT_STRING = 'Enter step descripion here...'

  belongs_to :recipe
end
