class ParsedLine < ApplicationRecord
  belongs_to :recipe
  belongs_to :image, optional: true
end
