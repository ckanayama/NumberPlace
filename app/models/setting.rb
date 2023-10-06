class Setting < ApplicationRecord
  enum :challenge_level, %i(easy normal hard)
  enum :theme, %i(default dark)
end
