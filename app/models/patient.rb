class Patient < ApplicationRecord
  validates :cost, presence: true,
                    length: { minimum: 1}
end
