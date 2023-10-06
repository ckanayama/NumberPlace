class Puzzle < ApplicationRecord
  has_one :number, dependent: :destroy

  enum :status, %i(draft submitted completed)
  enum :challenge_level, %i(easy normal hard)
end
