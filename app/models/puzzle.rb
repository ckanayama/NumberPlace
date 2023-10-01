class Puzzle < ApplicationRecord
  has_one :number, dependent: :destroy

  enum :status, %i(draft submitted completed)
end
